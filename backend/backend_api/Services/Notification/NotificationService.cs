using System;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.Notification;
using backend_api.Exceptions.Notifications;
using backend_api.Models.Notification;
using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;
using Castle.Core.Internal;
using Microsoft.Extensions.Options;
using MimeKit;
using SmtpClient = MailKit.Net.Smtp.SmtpClient;

namespace backend_api.Services.Notification
{
    public class NotificationService : INotificationService
    {
        private readonly INotificationRepository _repository;
        private readonly EmailSettings _settings;
        
        public NotificationService(INotificationRepository repository)
        {
            this._repository = repository;
        }
        
        public NotificationService(INotificationRepository repository, IOptions<EmailSettings> settings)
        {
            this._repository = repository;
            this._settings = settings.Value;
        }

        /// <inheritdoc />
        public async Task<RetrieveNotificationsResponse> RetrieveNotifications(RetrieveNotificationRequest request)
        {
            if (request == null)
            {
                throw new InvalidNotificationRequestException("Invalid RetrieveNotificationRequest object");
            }
            if (request.UserId is 0 or < 0)
            {
                throw new InvalidUserIdException("UserID is invalid");
            }
            
            var response = new RetrieveNotificationsResponse(
                await _repository.RetrieveNotifications(request)
            );
            
            return response;
        }

        /// <inheritdoc />
        public async Task<CreateNotificationResponse> CreateNotification(CreateNotificationRequest request)
        {
            if (request == null)
            {
                throw new InvalidNotificationRequestException("Invalid CreateNotificationRequest object");
            }
            if (request.UserId is 0 or < 0)
            {
                throw new InvalidUserIdException("UserID is invalid");
            }
            if (string.IsNullOrEmpty(request.Payload))
            {
                throw new InvalidPayloadException("Payload cannot be null or empty");
            }

            return await _repository.CreateNotification(request);
        }
        
        /// <inheritdoc />
        public async Task<SendEmailNotificationResponse> SendEmailNotification(SendEmailNotificationRequest request)
        {
            if (request.Email.IsNullOrEmpty())
            {
                throw new EmailFailedToSendException("Invalid email address, either null or empty");
            }
            if (request.Payload.Equals("") || request.Payload == null)
            {
                throw new EmailFailedToSendException("Invalid Payload, either null or empty");
            }
            if (request.Subject.Equals("") || request.Subject == null)
            {
                throw new EmailFailedToSendException("Invalid Subject, either null or empty");
            }
            if (request == null)
            {
                throw new EmailFailedToSendException("Request is null");
            }

            var email = new MimeMessage();
            var emailLists = new InternetAddressList();
            foreach (var address in request.Email)
            {
                emailLists.Add(MailboxAddress.Parse(address));
            }
            email.From.Add(new MailboxAddress(_settings.DisplayName,_settings.Mail));
            email.To.AddRange(emailLists);
            email.Subject = request.Subject;
            email.Body = new TextPart("plain")
            {
                Text = request.Payload
            };

            var client = new SmtpClient();
            try
            {
                await client.ConnectAsync(_settings.Host, _settings.Port, true);
                await client.AuthenticateAsync(_settings.Mail, _settings.Password);
                await client.SendAsync(email);

                var response = new SendEmailNotificationResponse(HttpStatusCode.Accepted);
                return response;
            }
            catch (Exception e)
            {
                var error = new SendEmailNotificationResponse(HttpStatusCode.BadRequest);
                return error;
            }
            finally
            {
                await client.DisconnectAsync(true);
                client.Dispose();
            }
        }
    }
}