﻿using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace backend_api.User.Data
{
    public interface IUserRepository
    {
        Task<List<Models.User.User>> GetUser(int userID);

        Task<List<Models.User.User>> GetUser(String firstname, String lastname);
        
        Task<IEnumerable<Models.User.User>> GetAllUsers();

        // Task<IAsyncEnumerable<Models.User.User>> AddUser(Models.User.User user);
        //
        // Task<IAsyncEnumerable<Models.User.User>> UpdateUser(Models.User.User user);
        //
        // Task<IAsyncEnumerable<Models.User.User>> DeleteUser(int userID);
        
        // Task<int> SaveChanges();

    }
}