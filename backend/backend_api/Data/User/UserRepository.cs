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
    public class UserRepository : DbContext, IUserRepository
    {
        private readonly IUserContext _users;
        
        public UserRepository(IUserContext users)
        {
            this._users = users;
        }

        public async Task<List<Models.User.User>> GetUser(int userID)
        {
            return await _users.users.Where(x => x.UserID == userID).ToListAsync();
        }
        public async Task<List<Models.User.User>> GetUser(String firstname, String lastname)
        {
            return await _users.users.Where(x => x.firstname == firstname && x.lastname==lastname).ToListAsync();
        }
        
        public async Task<IEnumerable<Models.User.User>> GetAllUsers()
        {
            var users = _users.users;
            IEnumerable<Models.User.User> allUsers = users.Select(user => user);
            
            // foreach (var user in users)
            // {
            //     allUsers.Add(user);
            // }
            
            return allUsers.ToList();
        }
        
        public ViewProfileResponse viewProfile(ViewProfileRequest request)
        {

            
            var selectedUser = _users.users.Where(x => x.UserID == request.GetUserId());

            var firstname = "";
            var lastname = "";
            var userImage = "";
            var description = "";
            var phoneNumber = 111;
            var empLevel = 111;
            var officeLocation = 111;
            var userRole = 111;

            foreach (var x in selectedUser)
            {
                firstname = x.firstname;
                lastname = x.lastname;
                userImage = x.userImage;
                description = x.userDescription;
                phoneNumber = x.phoneNumber;
                empLevel = x.employeeLevel;
                officeLocation = x.officeLocationID;
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

        public EditProfileResponse EditProfile(EditProfileRequest request)
        {
            var selectUserId = request.UserId;
            var user = _users.users.Where(u => u.UserID == selectUserId).FirstOrDefault();

            user.firstname = request.FirstName;
            user.lastname = request.LastName;
            user.phoneNumber = request.PhoneNumber;
            user.userDescription = request.UserDescription;
            user.userImage = request.UserImage;
            _users.SaveChanges();
            
            EditProfileResponse response = new EditProfileResponse("Successfully Edited User");
            
            return response;
        }
    }
}
