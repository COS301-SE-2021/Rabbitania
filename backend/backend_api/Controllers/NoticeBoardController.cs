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
    public class NoticeBoardController : ControllerBase
    {
        private readonly DatabaseContext _context;

        public NoticeBoardController(DatabaseContext context)
        {
            _context = context;
        }

        // GET: api/NoticeBoard
        [HttpGet]
        public async Task<ActionResult<IEnumerable<NoticeBoard>>> GetNoticeBoard()
        {
            return await _context.noticeBoard.ToListAsync();
        }

        // GET: api/NoticeBoard/5
        [HttpGet("{id}")]
        public async Task<ActionResult<NoticeBoard>> GetNoticeBoard(int id)
        {
            var noticeBoard = await _context.noticeBoard.FindAsync(id);

            if (noticeBoard == null)
            {
                return NotFound();
            }

            return noticeBoard;
        }

        // PUT: api/NoticeBoard/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutNoticeBoard(int id, NoticeBoard noticeBoard)
        {
            if (id != noticeBoard.NoticeBoardID)
            {
                return BadRequest();
            }

            _context.Entry(noticeBoard).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!NoticeBoardExists(id))
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

        // POST: api/NoticeBoard
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<NoticeBoard>> PostNoticeBoard(NoticeBoard noticeBoard)
        {
            _context.noticeBoard.Add(noticeBoard);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetNoticeBoard", new { id = noticeBoard.NoticeBoardID }, noticeBoard);
        }

        // DELETE: api/NoticeBoard/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteNoticeBoard(int id)
        {
            var noticeBoard = await _context.noticeBoard.FindAsync(id);
            if (noticeBoard == null)
            {
                return NotFound();
            }

            _context.noticeBoard.Remove(noticeBoard);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool NoticeBoardExists(int id)
        {
            return _context.noticeBoard.Any(e => e.NoticeBoardID == id);
        }
    }
}
