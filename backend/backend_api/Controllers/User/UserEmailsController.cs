using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Models;
using backend_api.Models.User;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Controllers.User
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserEmailsController : ControllerBase
    {
        private readonly UserEmailsContext _context;
        

        /// <summary>
        ///     
        ///     This class helps mainly to assist with user and the needs of the user subsystem
        ///     It's main responsibilities are to assist with storing the emails of a user,
        ///     as an employee of Retro Rabbit might have multiple different emails.
        /// 
        /// </summary>
        public UserEmailsController(UserEmailsContext context)
        {
            _context = context;
        }
        //TODO: endpoint for emails but put it in the user controller
        /// <summary>
        ///     Gets all users emails
        /// </summary>
        /// <returns>All the emails in UserEmails </returns>
         
        // [HttpGet("/api/GetAllEmails")]
        // public async Task<ActionResult<IEnumerable<UserEmails>>> GetAllUserEmails()
        // {
        //     
        //     return await _context.ToListAsync();
        // }

        /// <summary>
        ///     Gets a user's different emails, there could be one or many
        /// </summary>
        /// <param name="userID"></param>
        /// <returns> List of users emails </returns>
        // [HttpGet("/api/GetAUsersEmails/{userID}")]
        // public async Task<ActionResult<UserEmails>> GetEmails(int userID)
        // {
        //     var userEmails = await _context.FindAsync(userID);
        //
        //     if (userEmails == null)
        //     {
        //         return NotFound();
        //     }
        //     return userEmails;
        // }
        //
        // /// <summary>
        // ///     Adds a user's email to the database
        // /// </summary>
        // /// <param name="userEmail"></param>
        // /// <returns> a boolean that it has been saved succesfully </returns>
        // [HttpPost("/api/AddEmail")]
        // public async Task<ActionResult<UserEmails>> AddEmail(UserEmails userEmail)
        // {
        //     var userEmailId = userEmail.userEmailID;
        //     if (UserEmailsExists(userEmailId))
        //     {
        //         return StatusCode(StatusCodes.Status500InternalServerError, "User email already exists");
        //     }
        //    
        //     _context.Add(userEmail);
        //     await _context.SaveChanges();
        //     return CreatedAtAction("GetAllUserEmails", new { id = userEmail.userEmailID }, userEmail);
        // }
        //
        // private bool UserEmailsExists(int id)
        // {
        //     return _context.userEmails.Any(e => e.userEmailID == id);
        // }
    }
}
