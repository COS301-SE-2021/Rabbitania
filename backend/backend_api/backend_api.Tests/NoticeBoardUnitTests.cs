using System.Collections.Generic;
using backend_api.Models;
using Xunit;
namespace backend_api.Tests
{
    public class NoticeBoardUnitTests
    {
        private readonly NoticeBoard _sutNoticeBoard;


        public NoticeBoardUnitTests()
        {
            this._sutNoticeBoard = new NoticeBoard();
        }
        //Empty NoticeBoard Testing
        [Fact]
        public void GetEmptyNoticeBoard()
        {
            Assert.NotNull(_sutNoticeBoard);
        }
        //Get all empty variables
        [Fact]
        public void GetEmptyNoticeBoardId()
        {
            Assert.InRange<int>(_sutNoticeBoard.NoticeBoardID,0,100);
        }
        
        [Fact]
        public void GetEmptyNoticeBoardTitle()
        {
            string title = "";
            this._sutNoticeBoard.title = "";
            //expected
            Assert.Equal(title, this._sutNoticeBoard.title);
        }
        [Fact]
        public void GetEmptyNoticeBoardNumThreads()
        {
            List<int> ids = new List<int>();
            
            this._sutNoticeBoard.noticeBoardThreadIDs = new List<int>();
            //expected
            Assert.Equal(ids, this._sutNoticeBoard.noticeBoardThreadIDs);
        }
        [Fact]
        public void GetEmptyNoticeBoardThreadsList()
        {
            Assert.Null( _sutNoticeBoard.noticeBoardThreadIDs);
        }
        //set all variables
        //add threads
        [Fact]
        public void SetEmptyNoticeBoardId()
        {
            _sutNoticeBoard.NoticeBoardID = 101;
        }
        [Fact]
        public void SetEmptyNoticeBoardTitle()
        {
            _sutNoticeBoard.title = "Important Information";
        }
        [Fact]
        public void SetEmptyNoticeBoardThreadsList()
        {
            List<int> ThreadIds = new List<int>();
            ThreadIds.Add(1);
            ThreadIds.Add(2);
            ThreadIds.Add(3);
            ThreadIds.Add(4);
            ThreadIds.Add(5);
            ThreadIds.Add(6);
            ThreadIds.Add(7);
            ThreadIds.Add(8);
            ThreadIds.Add(9);
            ThreadIds.Add(10);


            _sutNoticeBoard.noticeBoardThreadIDs = ThreadIds;
        }
        //get num of threads and get threads and get their variables
        [Fact]
        public void GetNoticeBoardId()
        {
          
        }
        [Fact]
        public void GetNoticeBoardTitle()
        {
          
        }
        [Fact]
        public void GetNoticeBoardNumThreads()
        {
          
        }

        [Fact]
        public void GetNoticeBoardThreadsList()
        {

        }






    }
}