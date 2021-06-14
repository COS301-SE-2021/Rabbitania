using System;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace backend_api.Models.Auth.Responses
{
    public class GoogleResponse
    {
        private String _email;
        private String _token;
        private String _name;
        private String _givenName;
        private String _surname;

        public GoogleResponse() {}

        public GoogleResponse(String email, String token)
        {
            this._email = email;
            this._token = token;
        }

        public GoogleResponse(String email, String token, String givenName, String name, String surname)
        {
            this._email = email;
            this._name = name;
            this._token = token;
            this._surname = surname;
            this._givenName = givenName;
        }
        public override string ToString()
        {
            return this._email + ", " + this._token;
        }

        public JObject json()
        {
            var temp = new
            {
                Email = this._email,
                Token = this._token,
                GiveName = this._givenName,
                Name = this._name,
                Surname = this._surname
            };
            var jsonData = JsonConvert.SerializeObject(temp);
            JObject jsonObject = JObject.Parse(jsonData);
            return jsonObject;
        }
        public String Email
        {
            get => _email;
            set => _email = value;
        }
        public String Token
        {
            get => _token;
            set => _token = value;
        }
        public String Name
        {
            get => _name;
            set => _name = value;
        }
        public String Surname
        {
            get => _surname;
            set => _surname = value;
        }
        public String GivenName
        {
            get => _givenName;
            set => _givenName = value;
        }
    }
}