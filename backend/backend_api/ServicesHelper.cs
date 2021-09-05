using System;
using System.Text;
using backend_api.Models.User;
using backend_api.Services.User;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;

namespace backend_api
{
    public static class ServicesHelper
    {
        public static void ConfigJwt(this IServiceCollection services, IConfiguration configuration)
        {
            //TODO: change to simply using Firebase tokens instead of creating our own JWT on top of their token
            /*var settings = configuration.GetSection("JwtSettings");
            var secretKey = Environment.GetEnvironmentVariable("JWTSecret");
            services.AddAuthentication(o =>
            {
                o.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                o.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(o =>
            {
                o.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,
                    ValidIssuer = settings.GetSection("validIssuer").Value,
                    ValidAudience = settings.GetSection("validAudience").Value,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey ?? throw new InvalidOperationException()))
                };
            });*/
        }
    }
}