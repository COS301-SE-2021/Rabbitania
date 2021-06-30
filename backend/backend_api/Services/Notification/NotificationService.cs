﻿using System;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;
using backend_api.Data;
using backend_api.Data.Notification;
using backend_api.Exceptions.Notifications;
using backend_api.Models.Notification;
using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;
using Microsoft.Extensions.Options;
using MimeKit;
using MailKit;
using MailKit.Net.Smtp;
using Microsoft.EntityFrameworkCore.Metadata;
using SmtpClient = MailKit.Net.Smtp.SmtpClient;

namespace backend_api.Services.Notification
{
    public class NotificationService : INotificationService
    {
        private readonly INotificationRepository _repository;
        private readonly EmailSettings _settings;

        public NotificationService(INotificationRepository repository, IOptions<EmailSettings> settings)
        {
            this._repository = repository;
            this._settings = settings.Value;
        }

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

        public async Task<SendEmailNotificationResponse> SendEmailNotification(SendEmailNotificationRequest request)
        {
            if (request.Email.Equals("") || request.Email == null)
            {
                throw new EmailFailedToSendException("Invalid email address, either null or empty");
            }
            if (request.Payload.Equals("") || request.Payload == null)
            {
                throw new EmailFailedToSendException("Invalid email address, either null or empty");
            }
            if (request.Subject.Equals("") || request.Subject == null)
            {
                throw new EmailFailedToSendException("Invalid email address, either null or empty");
            }

            var email = new MimeMessage();
            email.From.Add(new MailboxAddress(_settings.DisplayName,_settings.Mail));
            email.To.Add(MailboxAddress.Parse(request.Email));
            email.Subject = request.Subject;
            email.Body = new TextPart("plain")
            {
                Text = request.Payload
            };

            var client = new SmtpClient();
            try
            {
                client.Connect(_settings.Host, _settings.Port, true);
                client.Authenticate(_settings.Mail, _settings.Password);
                await client.SendAsync(email);

                var response = new SendEmailNotificationResponse(HttpStatusCode.OK);
                return response;
            }
            catch (Exception exception)
            {
                var error = new SendEmailNotificationResponse(HttpStatusCode.BadRequest);
                return error;
            }
            finally
            {
                client.Disconnect(true);
                client.Dispose();
            }
        }
    }
}