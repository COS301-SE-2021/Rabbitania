using System;
using System.Collections.Generic;
using backend_api.Models;
using Moq;
using Xunit;

namespace backend_api.Tests
{
    public class UserUnitTests
    {
        private readonly User _sutUser;
        private readonly UserEmails _sutUserEmails;
        private IUserRepository userRepository;
        public UserUnitTests()
        {
            this._sutUser = new User();
            this._sutUserEmails = new UserEmails();
        }
        
        
        /// VERY NB FOR DEMO! WE WILL BE USING THE DOTNET MOQ SERVICE FROM DEMO 1
        ///
        /// <summary>
        ///  Creates a Moq enviornment for User Tests
        /// </summary>
        /*private void MoqCreation() 
        {
            var UserMoq = new Mock<IUserRepository>();
          
            // 2. Setup the returnables
            UserMoq
                .Setup(o => o.GetAllReaders(It.IsAny<string>()))
                .Returns(new List<User>() {
                    new User {
                        UserID = 1,
                        firstname = "Matthew",
                        lastname = "Harty",
                        phoneNumber = "+27834758854",
                        pinnedUserIDs = new List<int> {1,2,3},
                        userImage = "profile.png",
                        userDescription = "Likes coding for Web Dev",
                        isOnline = true,
                        isAdmin = true,
                        employeeLevel = 3,
                        userRoles = 0,
                        officeLocation = 0,
                        UserEmails = new List<int> {1,2}
                    }
                });
            
            userRepository = UserMoq.Object;
        }
        */
        
        [Fact]
        public void CreateNewUserInstanceIsNotNull()
        {
            // given
            User newTestUser;
            newTestUser = new User();
            // expected 
            Assert.NotNull(newTestUser);
        }
        
        [Fact]
        public void CreateNewUserEmailInstanceIsNotNull()
        {
            // given
            UserEmails newTestUserEmails;
            newTestUserEmails = new UserEmails();
            // expected
            Assert.NotNull(newTestUserEmails);
        }
        
        [Fact]
        public void CreateNewUserInstanceIsNull()
        {
            //given
            User newTestUser;
            newTestUser = null;
            //excepted
            Assert.Null(newTestUser);
        }
        
        [Fact]
        public void CreateNewUserEmailInstanceIsNull()
        {
            //given
            UserEmails newTestUserEmails;
            newTestUserEmails = null;
            //expected
            Assert.Null(newTestUserEmails);
        }

        [Fact]
        public void GetAndSetUserIdSuccess()
        {
            // given
            int expectedID = 1;
            this._sutUser.UserID = 1;
            //expected
            Assert.Equal(expectedID, this._sutUser.UserID);
        }
        
        [Fact]
        public void GetAndSetUserIdFail()
        {
            // given
            int expectedID = 1;
            this._sutUser.UserID = 2;
            //expected
            Assert.NotEqual(expectedID, this._sutUser.UserID);
        }
        
        [Fact]
        public void GetAndSetUserFirstnameSuccess()
        {
            // given
            string expectedFirstName = "Matthew";
            this._sutUser.firstname = "Matthew";
            //expected
            Assert.Equal(expectedFirstName, this._sutUser.firstname);
        }
        
        [Fact]
        public void GetAndSetUserFirstnameFail()
        {
            // given
            string expectedFirstName = "Matthew";
            this._sutUser.firstname = "msmdasmd";
            //expected
            Assert.NotEqual(expectedFirstName, this._sutUser.firstname);
        }
        
        [Fact]
        public void GetAndSetUserLastnameSuccess()
        {
            // given
            string expectedLastName = "Harty";
            this._sutUser.lastname = "Harty";
            //expected
            Assert.Equal(expectedLastName, this._sutUser.lastname);
        }
        
        [Fact]
        public void GetAndSetUserLastnameFail()
        {
            // given
            string expectedLastName = "Harty";
            this._sutUser.lastname = "Bob";
            //expected
            Assert.NotEqual(expectedLastName, this._sutUser.lastname);
        }
        
        [Fact]
        public void GetAndSetPhoneNumberSuccess()
        {
            // given
            string expectedPhoneNumber = "+27834758854";
            this._sutUser.phoneNumber = "+27834758854";
            //expected
            Assert.Equal(expectedPhoneNumber, this._sutUser.phoneNumber);
        }
        
        [Fact]
        public void GetAndSetPhoneNumberFail()
        {
            // given
            string expectedPhoneNumber = "+27834758854";
            this._sutUser.phoneNumber = "+27000000000";
            //expected
            Assert.NotEqual(expectedPhoneNumber, this._sutUser.phoneNumber);
        }

        [Fact]
        public void GetAndSetPinnedUserIdsSuccess()
        {
            //given
            List<int> expectedPinnedUserIDs;
            expectedPinnedUserIDs = new List<int> {1, 2};
            this._sutUser.pinnedUserIDs = new List<int> {1, 2};
            //expected
            Assert.Equal(expectedPinnedUserIDs, this._sutUser.pinnedUserIDs);
        }
        
        [Fact]
        public void GetAndSetPinnedUserIdsFail()
        {
            //given
            List<int> expectedPinnedUserIDs;
            expectedPinnedUserIDs = new List<int> {1,2};
            this._sutUser.pinnedUserIDs = new List<int> {1,2,3,5};
            //expected
            Assert.NotEqual(expectedPinnedUserIDs, this._sutUser.pinnedUserIDs);
        }

        [Fact]
        public void GetAndSetUserImageSuccess()
        {
            //given
            string expectedUserImage; 
            expectedUserImage= "profile.png";
            this._sutUser.userImage = "profile.png";
            //expected
            Assert.Equal(expectedUserImage, this._sutUser.userImage);
        }

        [Fact]
        public void GetAndSetUserImageFail()
        {
            //given
            string expectedUserImage; 
            expectedUserImage= "profile.png";
            this._sutUser.userImage = "hello.png";
            //expected
            Assert.NotEqual(expectedUserImage, this._sutUser.userImage);
        }
        
        [Fact]
        public void GetAndSetUserDescriptionSuccess()
        {
            //given
            string expectedUserDesc; 
            expectedUserDesc= "Hello my name is Matthew";
            this._sutUser.userDescription = "Hello my name is Matthew";
            //expected
            Assert.Equal(expectedUserDesc, this._sutUser.userDescription);
        }
        
        [Fact]
        public void GetAndSetUserDescriptionFail()
        {
            //given
            string expectedUserDesc; 
            expectedUserDesc= "Hello my name is Matt";
            this._sutUser.userDescription = "Hello my name is Matthew";
            //expected
            Assert.NotEqual(expectedUserDesc, this._sutUser.userDescription);
        }
        
        [Fact]
        public void GetAndSetIsOnlineSuccess()
        {
            //given
            bool isOnlineTest; 
            isOnlineTest = true;
            this._sutUser.isOnline = true;
            //expected
            Assert.Equal(isOnlineTest, this._sutUser.isOnline);
        }
        
        [Fact]
        public void GetAndSetIsOnlineFail()
        {
            //given
            bool isOnlineTest; 
            isOnlineTest = true;
            this._sutUser.isOnline = false;
            //expected
            Assert.NotEqual(isOnlineTest, this._sutUser.isOnline);
        }
        
        [Fact]
        public void GetAndSetIsAdminSuccess()
        {
            //given
            bool isAdminTest; 
            isAdminTest = true;
            this._sutUser.isAdmin = true;
            //expected
            Assert.Equal(isAdminTest, this._sutUser.isAdmin);
        }
        
        [Fact]
        public void GetAndSetIsAdminFail()
        {
            //given
            bool isAdminTest; 
            isAdminTest = true;
            this._sutUser.isAdmin = false;
            //expected
            Assert.NotEqual(isAdminTest, this._sutUser.isAdmin);
        }
        
        [Fact]
        public void GetAndSetEmployeeLevelSuccess()
        {
            //given
            int empLevel; 
            empLevel = 1;
            this._sutUser.employeeLevel = 1;
            //expected
            Assert.Equal(empLevel, this._sutUser.employeeLevel);
        }
        
        [Fact]
        public void GetAndSetEmployeeLevelFail()
        {
            //given
            int empLevel; 
            empLevel = 1;
            this._sutUser.employeeLevel = 0;
            //expected
            Assert.NotEqual(empLevel, this._sutUser.employeeLevel);
        }
        
        [Fact]
        public void GetAndSetUserRolesSuccess()
        {
            //given
            UserRoles enumRoles;
            enumRoles = UserRoles.Developer;
            this._sutUser.userRoles = UserRoles.Developer;
            //expected
            Assert.Equal(enumRoles, this._sutUser.userRoles);
        }
        
        [Fact]
        public void GetAndSetUserRolesFail()
        {
            //given
            UserRoles enumRoles;
            enumRoles = UserRoles.Developer;
            this._sutUser.userRoles = UserRoles.Designer;
            //expected
            Assert.NotEqual(enumRoles, this._sutUser.userRoles);
        }
        
        [Fact]
        public void GetAndSetOfficeLocationSuccess()
        {
            //given
            OfficeLocation offLocations;
            offLocations = OfficeLocation.Pretoria;
            this._sutUser.officeLocation = OfficeLocation.Pretoria;
            //expected
            Assert.Equal(offLocations, this._sutUser.officeLocation);
        }
        
        [Fact]
        public void GetAndSetOfficeLocationFail()
        {
            //given
            OfficeLocation offLocations;
            offLocations = OfficeLocation.Pretoria;
            this._sutUser.officeLocation = OfficeLocation.Braamfontein;
            //expected
            Assert.NotEqual(offLocations, this._sutUser.officeLocation);
        }
        
        /// <summary>
        /// TESTS USER EMAIL CLASSES AND IS A SUBSYSTEM OF THE USER SUBSYSTEM
        /// </summary>
        [Fact]
        public void GetAndSetUserEmailsIdSuccess()
        {
            // given
            int expectedID = 1;
            this._sutUserEmails.userEmailsID = 1;
            //expected
            Assert.Equal(expectedID, this._sutUserEmails.userEmailsID);
        }
        
        [Fact]
        public void GetAndSetUserEmailsIdFail()
        {
            // given
            int expectedID = 1;
            this._sutUserEmails.userEmailsID = 0;
            //expected
            Assert.NotEqual(expectedID, this._sutUserEmails.userEmailsID);
        }
        
        [Fact]
        public void GetAndSetUserEmailSuccess()
        {
            // given
            string userEmailTest = "mattharty@retrorabbit.co.za";
            this._sutUserEmails.userEmail = "mattharty@retrorabbit.co.za";
            //expected
            Assert.Equal(userEmailTest, this._sutUserEmails.userEmail);
        }
        
        [Fact]
        public void GetAndSetUserEmailFail()
        {
            // given
            string userEmailTest = "mattharty@retrorabbit.co.za";
            this._sutUserEmails.userEmail = "sdfdsfsdfsfsdfsdf";
            //expected
            Assert.NotEqual(userEmailTest, this._sutUserEmails.userEmail);
        }
    }
}