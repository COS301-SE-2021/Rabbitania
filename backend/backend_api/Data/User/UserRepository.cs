using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Models.User;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using Microsoft.EntityFrameworkCore;

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
            return await _users.Users.Where(x => x.firstname == firstname && x.lastname==lastname).ToListAsync();
        }


        public CreateUserResponse CreateUser(CreateUserRequest request)
        {
            Models.User.User newUser = new Models.User.User(request.UserId, request.FirstName, request.LastName,
                request.PhoneNumber, request.PinnedUserIds, request.UserImage, request.UserDescription,
                request.IsOnline, request.IsAdmin, request.EmployeeLevel, request.UserRole, request.OfficeLocation);

            _users.Users.Add(newUser);
            _users.SaveChanges();

            return new CreateUserResponse("User Successfully Created");
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

            ViewProfileResponse response = new ViewProfileResponse("Succesfully Viewed Profile", firstname, lastname, userImage, description, phoneNumber,empLevel,userRole, officeLocation);

            
            return response;
            
            
        }

        //TODO: implement the rest of the functions needed in the repository class
        // public async Task<IAsyncEnumerable<Models.User.User>> DeleteUser(int userID)
        // {
        //     
        // }
        //
        // public async Task<IAsyncEnumerable<Models.User.User>> AddUser(Models.User.User User)
        // {
        //                 
        // }
        //
        // public async Task<IAsyncEnumerable<Models.User.User>> UpdateUser(Models.User.User User)
        // {
        //     
        // }
        // public DbSet<Models.User.User> users { get; set; }

        public async Task<EditProfileResponse> EditProfile(EditProfileRequest request)
        {
            var toUpdate = _users.Users.FirstOrDefault(uu => uu.UserID == request.UserId);

            toUpdate.firstname = request.FirstName;
            toUpdate.lastname = request.LastName;
            toUpdate.phoneNumber = request.PhoneNumber;
            toUpdate.userImage = request.UserImage;
            toUpdate.userDescription = request.UserDescription;
            _users.Entry(toUpdate).State = EntityState.Modified;
            
            try
            {
                await _users.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
            }
            
            EditProfileResponse response = new EditProfileResponse("Successfully updated user");
            return response;
        }
    }
}
