using System;
using System.Collections.Generic;
using System.Data;
using System.Dynamic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using backend_api.Models.User;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;
using CreateEmailRequest = backend_api.Models.User.Requests.CreateEmailRequest;

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
            return await _users.Users.Where(x => x.UserID == userID).ToListAsync();
        }

        public async Task<List<Models.User.User>> GetUser(String firstname, String lastname)
        {
            return await _users.Users.Where(x => x.firstname == firstname && x.lastname == lastname).ToListAsync();
        }


        public CreateUserResponse CreateUser(CreateUserRequest request)
        {
            Models.User.User newUser = new Models.User.User(request.UserId, request.FirstName, request.LastName,
                request.PhoneNumber, request.PinnedUserIds, request.UserImage, request.UserDescription,
                request.IsOnline, request.IsAdmin, request.EmployeeLevel, request.UserRole, request.OfficeLocation);

            //TODO: User's email should also be added to the repo

            _users.Users.Add(newUser);
            _users.SaveChanges();

            return new CreateUserResponse("User Successfully Created");
        }

        public CreateEmailResponse CreateUserEmail(CreateUserRequest userRequest, CreateEmailRequest emailRequest)
        {
            UserEmails userEmail = new UserEmails(emailRequest.EmailId, emailRequest.Email, userRequest.UserId);
            _users.SaveChanges();

            return new CreateEmailResponse("User Email Successfully Created");
        }


        public async Task<IEnumerable<Models.User.User>> GetAllUsers()
        {
            var users = _users.Users;
            IEnumerable<Models.User.User> allUsers = users.Select(user => user);

            // foreach (var user in users)
            // {
            //     allUsers.Add(user);
            // }

            return allUsers.ToList();
        }

        public ViewProfileResponse ViewProfile(ViewProfileRequest request)
        {
            var selectedUser = _users.Users.Where(x => x.UserID == request.UserId);
            
            var firstname = "";
            var lastname = "";
            var userImage = "";
            var description = "";
            var phoneNumber = 111;
            var empLevel = 111;
            OfficeLocation officeLocation = OfficeLocation.Braamfontein;
            UserRoles userRole = UserRoles.Administrator;

            foreach (var x in selectedUser)
            {
                firstname = x.firstname;
                lastname = x.lastname;
                userImage = x.userImage;
                description = x.userDescription;
                phoneNumber = x.phoneNumber;
                empLevel = x.employeeLevel;
                officeLocation = x.officeLocation;
                userRole = x.userRole;
            }

            ViewProfileResponse response = new ViewProfileResponse("Succesfully Viewed Profile", firstname, lastname,
                userImage, description, phoneNumber, empLevel, userRole, officeLocation);

            return response;
        }

        public async Task<EditProfileResponse> EditProfile(EditProfileRequest request)
        {
            var toUpdate = _users.Users.FirstOrDefault(uu => uu.UserID == request.UserId);

            toUpdate.firstname = request.FirstName;
            toUpdate.lastname = request.LastName;
            toUpdate.phoneNumber = request.PhoneNumber;
            toUpdate.userImage = request.UserImage;
            toUpdate.userDescription = request.UserDescription;
            toUpdate.officeLocation = request.OfficeLocation;
            _users.Entry(toUpdate).State = EntityState.Modified;

            try
            {
                await _users.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                throw new DbUpdateException("Error when updating user" + request.FirstName);
            }

            var response = new EditProfileResponse("Successfully updated user");

            return response;
        }

        public bool checkEmailExists(GoogleSignInRequest request)
        {
            var userEmail = _users.UserEmail.Where(x => x.userEmail == request.Email);
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
            var userEmail = await _users.UserEmail.FirstOrDefaultAsync(x => x.userEmail == email);
            var user = await _users.Users.FirstOrDefaultAsync(x => x.UserID == userEmail.UserID);
            return user;
        }
    }
}