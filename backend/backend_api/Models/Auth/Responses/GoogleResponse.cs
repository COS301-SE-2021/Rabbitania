using System;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace backend_api.Models.Auth.Responses
{
    public class GoogleResponse
    {
        private String _email { get; set; }
        private String _token { get; set; }
        private String _name { get; set; }
        private String _givenName { get; set; }
        private String _surname { get; set; }

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

        public JObject json(String email, String token, String givenName, String name, String surname)
        {
            var temp = new
            {
                Email = email,
                Token = token,
                GiveName = givenName,
                Name = name,
                Surname = surname
            };
            var jsonData = JsonConvert.SerializeObject(temp);
            JObject jsonObject = JObject.Parse(jsonData);
            Console.WriteLine(jsonObject);
            return jsonObject;
        }
    }
}