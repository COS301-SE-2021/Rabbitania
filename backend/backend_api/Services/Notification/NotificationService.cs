using System;
using System.Collections.Generic;
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
using RestSharp;
using RestSharp.Authenticators;
using SendGrid;
using SendGrid.Helpers.Mail;
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
            var displayName = Environment.GetEnvironmentVariable("EmailSettings_DisplayName");
            var mailAddressFrom = Environment.GetEnvironmentVariable("EmailSettings_Mail");
            
            var emailsTo = new List<EmailAddress>();
            foreach (var address in request.Email)
            {
                emailsTo.Add(new EmailAddress(address));
            }
            var apikey = Environment.GetEnvironmentVariable("SENDGRID_PASSWORD");
            var client = new SendGridClient(apikey);
            var from = new EmailAddress(mailAddressFrom, displayName);
            var bodyContent = new TextPart("plain")
            {
                Text = request.Payload
            };
            var msg = MailHelper.CreateSingleEmailToMultipleRecipients(from, emailsTo, request.Subject, bodyContent.Text, "");
            
            try 
            {
                 var response = await client.SendEmailAsync(msg);
                 if (response.IsSuccessStatusCode)
                 {
                     return new SendEmailNotificationResponse(HttpStatusCode.Accepted);
                 }
                 else
                 {
                     return new SendEmailNotificationResponse(HttpStatusCode.InternalServerError);
                 }
            }
            catch (Exception e)
            {
                return new SendEmailNotificationResponse(HttpStatusCode.BadRequest); 
            }
        }
    }
}