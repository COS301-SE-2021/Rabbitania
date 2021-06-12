﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
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
    }
}