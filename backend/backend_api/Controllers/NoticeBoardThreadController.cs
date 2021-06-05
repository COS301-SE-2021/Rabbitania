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
    public class NoticeBoardThreadController : ControllerBase
    {
        private readonly DatabaseContext _context;

        public NoticeBoardThreadController(DatabaseContext context)
        {
            _context = context;
        }

        // GET: api/NoticeBoardThread
        [HttpGet]
        public async Task<ActionResult<IEnumerable<NoticeBoardThread>>> GetNoticeBoardThreads()
        {
            return await _context.noticeBoardThreads.ToListAsync();
        }

        // GET: api/NoticeBoardThread/5
        [HttpGet("{id}")]
        public async Task<ActionResult<NoticeBoardThread>> GetNoticeBoardThread(int id)
        {
            var noticeBoardThread = await _context.noticeBoardThreads.FindAsync(id);

            if (noticeBoardThread == null)
            {
                return NotFound();
            }

            return noticeBoardThread;
        }

        // PUT: api/NoticeBoardThread/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutNoticeBoardThread(int id, NoticeBoardThread noticeBoardThread)
        {
            if (id != noticeBoardThread.threadID)
            {
                return BadRequest();
            }

            _context.Entry(noticeBoardThread).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!NoticeBoardThreadExists(id))
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

        // POST: api/NoticeBoardThread
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<NoticeBoardThread>> PostNoticeBoardThread(NoticeBoardThread noticeBoardThread)
        {
            _context.noticeBoardThreads.Add(noticeBoardThread);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetNoticeBoardThread", new { id = noticeBoardThread.threadID }, noticeBoardThread);
        }

        // DELETE: api/NoticeBoardThread/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteNoticeBoardThread(int id)
        {
            var noticeBoardThread = await _context.noticeBoardThreads.FindAsync(id);
            if (noticeBoardThread == null)
            {
                return NotFound();
            }

            _context.noticeBoardThreads.Remove(noticeBoardThread);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool NoticeBoardThreadExists(int id)
        {
            return _context.noticeBoardThreads.Any(e => e.threadID == id);
        }
    }
}
