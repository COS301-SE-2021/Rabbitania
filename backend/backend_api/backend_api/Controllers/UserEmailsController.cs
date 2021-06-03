using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using backend_api.Models;

namespace backend_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserEmailsController : ControllerBase
    {
        private readonly DatabaseContext _context;

        public UserEmailsController(DatabaseContext context)
        {
            _context = context;
        }

        // GET: api/UserEmails
        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserEmails>>> GetuserEmails()
        {
            return await _context.userEmails.ToListAsync();
        }

        // GET: api/UserEmails/5
        [HttpGet("{id}")]
        public async Task<ActionResult<UserEmails>> GetUserEmails(int id)
        {
            var userEmails = await _context.userEmails.FindAsync(id);

            if (userEmails == null)
            {
                return NotFound();
            }

            return userEmails;
        }

        // PUT: api/UserEmails/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutUserEmails(int id, UserEmails userEmails)
        {
            if (id != userEmails.userEmailID)
            {
                return BadRequest();
            }

            _context.Entry(userEmails).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UserEmailsExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/UserEmails
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<UserEmails>> PostUserEmails(UserEmails userEmails)
        {
            _context.userEmails.Add(userEmails);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUserEmails", new { id = userEmails.userEmailID }, userEmails);
        }

        // DELETE: api/UserEmails/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUserEmails(int id)
        {
            var userEmails = await _context.userEmails.FindAsync(id);
            if (userEmails == null)
            {
                return NotFound();
            }

            _context.userEmails.Remove(userEmails);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool UserEmailsExists(int id)
        {
            return _context.userEmails.Any(e => e.userEmailID == id);
        }
    }
}
