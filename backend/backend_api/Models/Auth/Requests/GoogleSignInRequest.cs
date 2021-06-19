using System;
using Microsoft.IdentityModel.JsonWebTokens;

namespace backend_api.Models.Auth.Requests
{
    public class GoogleSignInRequest
    {
        private string _displayName;
        private string _email;
        private string _phoneNumber;
        private string _googleImgUrl;
        
        public GoogleSignInRequest()
        {
            
        }

        public GoogleSignInRequest(string displayName, string email, string phoneNumber, string googleImgUrl)
        {
            this._displayName = displayName;
            this._email = email;
            this._phoneNumber = phoneNumber;
            this._googleImgUrl = googleImgUrl;
        }

        public GoogleSignInRequest(string email)
        {
            _email = email;
        }

        public string DisplayName
        {
            get => _displayName;
            set => _displayName = value;
        }

        public string Email
        {
            get => _email;
            set => _email = value;
        }

        public string PhoneNumber
        {
            get => _phoneNumber;
            set => _phoneNumber = value;
        }

        public string GoogleImgUrl
        {
            get => _googleImgUrl;
            set => _googleImgUrl = value;
        }
    }
}