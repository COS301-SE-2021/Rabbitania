﻿using System;
using backend_api.Data.User;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;

namespace backend_api.Services.Auth
{
    public class AuthService : IAuthService
    {
        private readonly IUserRepository _repository;

        public LoginResponse checkEmailExists(GoogleSignInRequest request)
        {
            // throw new System.NotImplementedException();
            String email = request.Email;
            if (email == null)
            {
                throw new Exception("User Email Missing");
            }
            //Checks if email received by request is in the UserEmails repo
            if (_repository.checkEmailExists(request))
            {
                return new LoginResponse(true);
            }
            else
            {
                return new LoginResponse(false);
            }
        }

        public AuthService(IUserRepository repository)
        {
            this._repository = repository;
        }

        public DomainResponse CheckEmailDomain(GoogleSignInRequest request)
        {
            var email = request.Email;
            var arr = email.Split('@');
            //TODO: Change to retrorabbit.co.za once we have a test email to work with
            if (arr[1].Equals("castellodev.co.za"))
            {
                return new DomainResponse(true);
            }
            else
            {
                return new DomainResponse(false);
            }
            
        }

        
    }
    
}