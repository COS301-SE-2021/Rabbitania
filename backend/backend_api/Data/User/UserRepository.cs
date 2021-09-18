using System;
using System.Collections.Generic;
using System.Data;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using backend_api.Exceptions.User;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using backend_api.Models.Enumerations;
using backend_api.Models.User;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using Castle.Core.Internal;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;
using Org.BouncyCastle.Utilities.Collections;

namespace backend_api.Data.User
{
    public class UserRepository : IUserRepository
    {
        private readonly UserContext _users;
        private readonly IdentityContext _aspUser;


        public UserRepository(UserContext users)
        {
            this._users = users;
        }

        public UserRepository(UserContext users, IdentityContext aspUser)
        {
            _users = users;
            _aspUser = aspUser;
        }

        public async Task<Models.User.Users> GetUser(int userID)
        {
            return await _users.Users.Where(x => x.UserId == userID).FirstOrDefaultAsync();
            
        }

        public async Task<Models.User.Users> GetUserByEmail(string email)
        {
            var userEmail = _users.UserEmail.Where(x => x.UsersEmail == email).FirstOrDefaultAsync();
            var userID = userEmail.Result.UserId;
            return await _users.Users.Where(x => x.UserId == userID).FirstOrDefaultAsync();
        }

        public async Task<List<Models.User.Users>> GetUser(String name)
        {
            var resp = await _users.Users.Where(x => x.Name == name).ToListAsync();
            if (resp.Count == 0)
            {
                throw new InvalidUserRequestException("User: "+name+" does not exist in the database");
            }

            return resp;
        }


        public async Task<CreateUserResponse> CreateUser(GoogleSignInRequest request)
        {
            var newUser = new Models.User.Users();
            newUser.Name = request.DisplayName;
            newUser.PhoneNumber = "0833611023";
            newUser.PinnedUserIds = new List<int>();
            newUser.UserImgUrl = request.GoogleImgUrl;
            newUser.UserDescription = "No Description...";
            newUser.IsAdmin = false;
            newUser.EmployeeLevel = 0;
            newUser.UserRole = UserRoles.Unassigned;
            newUser.OfficeLocation = OfficeLocation.Unassigned;
            
            await _users.Users.AddAsync(newUser);
            await _users.SaveChangesAsync();
            
            var newEmail = new UserEmails(request.Email, newUser.UserId);
            await _users.UserEmail.AddAsync(newEmail);
            
            await _users.SaveChangesAsync();

            return new CreateUserResponse("User Successfully Created");
        }

        public async Task<IEnumerable<Models.User.Users>> GetAllUsers()
        {
            var users = _users.Users;
            IEnumerable<Models.User.Users> allUsers = users.Select(user => user);

            return allUsers.ToList();
        }

        public ViewProfileResponse ViewProfileAsp(ViewProfileRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request object cannot be null");
            }
            var selectedUser = _aspUser.Users.Where(x => x.UserId == request.UserId);
            
            var name = "";
            var userImage = "";
            var description = "";
            var phoneNumber = "";
            var empLevel = 111;
            OfficeLocation officeLocation = OfficeLocation.Braamfontein;
            UserRoles userRole = UserRoles.Administrator;

            foreach (var x in selectedUser)
            {
                name = x.Name;
                userImage = x.UserImgUrl;
                description = x.UserDescription;
                phoneNumber = x.PhoneNumber;
                empLevel = x.EmployeeLevel;
                officeLocation = x.OfficeLocation;
                userRole = x.UserRole;
            }

            ViewProfileResponse response = new ViewProfileResponse(HttpStatusCode.OK, name,
                userImage, description, phoneNumber, empLevel, userRole, officeLocation);

            return response;
        }

        public async Task<ViewProfileResponse> ViewProfile(ViewProfileRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request object cannot be null");
            }

            var selectedUser =  _users.Users.Where(x => x.UserId == request.UserId);
            
            var name = "";
            var userImage = "";
            var description = "";
            var phoneNumber = "";
            var empLevel = 111;
            OfficeLocation officeLocation = OfficeLocation.Braamfontein;
            UserRoles userRole = UserRoles.Administrator;

            foreach (var x in selectedUser)
            {
                name = x.Name;
                userImage = x.UserImgUrl;
                description = x.UserDescription;
                phoneNumber = x.PhoneNumber;
                empLevel = x.EmployeeLevel;
                officeLocation = x.OfficeLocation;
                userRole = x.UserRole;
            }

            if (name == "")
            { 
                return new ViewProfileResponse(HttpStatusCode.BadGateway);
            }
            var response = new ViewProfileResponse(HttpStatusCode.OK, name,
                userImage, description, phoneNumber, empLevel, userRole, officeLocation);

            return response;
        }
        
        public async Task<GetUserProfilesResponse> GetUserProfiles()
        {
            var users = _users.Users;
            IEnumerable<Users> allUsers = users.Select(user => user);

            var listOfUsers = allUsers.ToList();
            var listOfUserProfiles = new List<Users>();

            foreach (var user in listOfUsers)
            {
                listOfUserProfiles.Add(new Users(user.UserId, user.Name, user.PhoneNumber, user.UserImgUrl, user.UserDescription, user.EmployeeLevel, user.OfficeLocation, user.UserRole));
            }

            return new GetUserProfilesResponse(listOfUserProfiles);
        }

        public async Task<EditProfileResponse> EditProfile(EditProfileRequest request)
        {
            var toUpdate = await _users.Users.FirstOrDefaultAsync(uu => uu.UserId == request.UserId);
            
            /*if(request.Name != )*/
            
            toUpdate.Name = request.Name;
            toUpdate.PhoneNumber = request.PhoneNumber;
            toUpdate.UserImgUrl = request.UserImage;
            toUpdate.UserDescription = request.UserDescription;
            toUpdate.OfficeLocation = request.OfficeLocation;
            toUpdate.EmployeeLevel = request.EmployeeLevel;
            toUpdate.UserRole = request.UserRoles;
            _users.Entry(toUpdate).State = EntityState.Modified;

            try
            {
                await _users.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                throw new DbUpdateException("Error when updating user" + request.Name);
            }

            var response = new EditProfileResponse(HttpStatusCode.Accepted);

            return response;
        }

        public async Task<bool> checkEmailExists(GoogleSignInRequest request)
        {
            var userEmail = await _users.UserEmail.Where(x => x.UsersEmail == request.Email).ToListAsync();
            //Check if IQueryable returns something
            if (userEmail.Any())
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public async Task<Models.User.Users> GetExistingUserDetails(GoogleSignInRequest request)
        {
            var email = request.Email;
            //get email object for the given email
            var userEmail = await _users.UserEmail.FirstOrDefaultAsync(x => x.UsersEmail == email);
            var user = await _users.Users.FirstOrDefaultAsync(x => x.UserId == userEmail.UserId);
            return user;
        }

        public List<string> GetAllUserEmails()
        {
            var emails = _users.UserEmail.Select(e => e.UsersEmail).Distinct().ToList();
            
            return emails;
        }

        public async Task<MakeUserAdminResponse> MakeUserAdmin(MakeUserAdminRequest request)
        {
            try
            {
                var user = await _users.Users.FirstOrDefaultAsync(x => x.UserId == request.UserId);

                try
                {
                    user.IsAdmin = true;
                    await _users.SaveChangesAsync();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }

                return new MakeUserAdminResponse("User successfully made Admin", HttpStatusCode.OK);
            }
            catch (Exception e)
            {
                return new MakeUserAdminResponse(e.Message, HttpStatusCode.BadRequest);
            }
        }
    }
}