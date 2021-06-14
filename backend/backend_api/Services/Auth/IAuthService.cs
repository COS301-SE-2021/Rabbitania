﻿using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;

namespace backend_api.Services.Auth
{
    public interface IAuthService
    {
        GoogleResponse GoogleAuthResponse(GoogleSignInRequest request);
    }
}