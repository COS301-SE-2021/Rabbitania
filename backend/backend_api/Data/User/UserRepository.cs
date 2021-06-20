using System;
using System.Collections.Generic;
using System.Data;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using backend_api.Models.User;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;

namespace backend_api.Data.User
{
    public class UserRepository : IUserRepository
    {
        private readonly UserContext _users;

        public UserRepository(UserContext users)
        {
            this._users = users;
        }

        public async Task<List<Models.User.User>> GetUser(int userID)
        {
            return await _users.Users.Where(x => x.UserId == userID).ToListAsync();
        }

        public async Task<List<Models.User.User>> GetUser(String name)
        {
            return await _users.Users.Where(x => x.Name == name).ToListAsync();
        }


        public async Task<CreateUserResponse> CreateUser(GoogleSignInRequest request)
        {
            var newUser = new Models.User.User();
            newUser.Name = request.DisplayName;
            newUser.PhoneNumber = request.PhoneNumber;
            newUser.PinnedUserIds = new List<int>();
            newUser.UserImgUrl = request.GoogleImgUrl;
            newUser.UserDescription = "No Description...";
            newUser.IsAdmin = false;
            newUser.EmployeeLevel = 0;
            newUser.UserRole = UserRoles.Unassigned;
            newUser.OfficeLocation = OfficeLocation.Unassigned;
            
            _users.Users.Add(newUser);
            await _users.SaveChanges();
            
            var newEmail = new UserEmails(request.Email, newUser.UserId);
            _users.UserEmail.Add(newEmail);
            
            await _users.SaveChanges();

            return new CreateUserResponse("User Successfully Created");
        }

        public async Task<IEnumerable<Models.User.User>> GetAllUsers()
        {
            var users = _users.Users;
            IEnumerable<Models.User.User> allUsers = users.Select(user => user);

            return allUsers.ToList();
        }

        public ViewProfileResponse ViewProfile(ViewProfileRequest request)
        {
            var selectedUser = _users.Users.Where(x => x.UserId == request.UserId);
            
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

        public async Task<EditProfileResponse> EditProfile(EditProfileRequest request)
        {
            var toUpdate = _users.Users.FirstOrDefault(uu => uu.UserId == request.UserId);

            toUpdate.Name = request.Name;
            toUpdate.PhoneNumber = request.PhoneNumber;
            toUpdate.UserImgUrl = request.UserImage;
            toUpdate.UserDescription = request.UserDescription;
            toUpdate.OfficeLocation = request.OfficeLocation;
            _users.Entry(toUpdate).State = EntityState.Modified;

            try
            {
                await _users.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                throw new DbUpdateException("Error when updating user" + request.Name);
            }

            var response = new EditProfileResponse("Successfully updated user");

            return response;
        }

        public async Task<bool> checkEmailExists(GoogleSignInRequest request)
        {
            var userEmail = await _users.UserEmail.Where(x => x.UserEmail == request.Email).ToListAsync();
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

        public async Task<Models.User.User> GetExistingUserDetails(GoogleSignInRequest request)
        {
            var email = request.Email;
            //get email object for the given email
            var userEmail = await _users.UserEmail.FirstOrDefaultAsync(x => x.UserEmail == email);
            var user = await _users.Users.FirstOrDefaultAsync(x => x.UserId == userEmail.UserId);
            return user;
        }
    }
}