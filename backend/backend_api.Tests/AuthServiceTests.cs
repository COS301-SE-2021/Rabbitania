using System;
using System.Collections.Generic;
using backend_api.Data.User;
using backend_api.Exceptions.Auth;
using backend_api.Models;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using backend_api.Models.User;
using backend_api.Services.Auth;
using Moq; 
using Xunit;
using Xunit.Sdk;

namespace backend_api.Tests
{
    public class AuthUniTests
    {
        private readonly AuthService _authService;
        private readonly Mock<IUserRepository> _userRepositoryMock = new Mock<IUserRepository>();
        public AuthUniTests()
        {
            _authService = new AuthService(_userRepositoryMock.Object);
        }
        
        [Fact]
        public void InvalidDomainLogin()
        {
            //Arrange
            String email = "test@gmail.com";
            GoogleSignInRequest request1 = new GoogleSignInRequest(email);
            
            //Act
            var response = _authService.CheckEmailDomain(request1);
            //Assert
            Assert.NotNull(response);
            Assert.IsType<DomainResponse>(response);
        }
        //TODO: finish test
        [Fact]
        public void invalidEmailLogin()
        {
            
            String email = "hi@castellodev.co.za";
            
        }
        //TODO: Check why I get a TestClassException error
        
    }
    
}