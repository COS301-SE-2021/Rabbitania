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
            Assert.Equal("",_sutNoticeBoard.title);
        }
        [Fact]
        public void GetEmptyNoticeBoardNumThreads()
        {
            Assert.InRange<int>(_sutNoticeBoard.getNumberOfThreads(),0,100);
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
           

            NoticeBoardThread thread1 = new NoticeBoardThread();
            thread1.threadID = 1;
            thread1.ThreadTitle = "Help";
            thread1.ThreadContent = "Content Here";
            thread1.ThreadCreationDate = "2021";
            thread1.ThreadDueDate = "2022";
            thread1.UserID = 102;
            
            NoticeBoardThread thread2 = new NoticeBoardThread();
            thread2.threadID = 1;
            thread2.ThreadTitle = "Help";
            thread2.ThreadContent = "Content Here";
            thread2.ThreadCreationDate = "2021";
            thread2.ThreadDueDate = "2022";
            thread2.UserID = 102;
            
            NoticeBoardThread thread3 = new NoticeBoardThread();
            thread3.threadID = 1;
            thread3.ThreadTitle = "Help";
            thread3.ThreadContent = "Content Here";
            thread3.ThreadCreationDate = "2021";
            thread3.ThreadDueDate = "2022";
            thread3.UserID = 102;
            
            NoticeBoardThread thread4 = new NoticeBoardThread();
            thread4.threadID = 1;
            thread4.ThreadTitle = "Help";
            thread4.ThreadContent = "Content Here";
            thread4.ThreadCreationDate = "2021";
            thread4.ThreadDueDate = "2022";
            thread4.UserID = 102;
            
            
            _sutNoticeBoard.noticeBoardThreadIDs = ThreadIds;
        }
        //get num of threads and get threads and get their variables
        [Fact]
        public void GetNoticeBoardId()
        {
            Assert.Equal(101, _sutNoticeBoard.NoticeBoardID);
        }
        [Fact]
        public void GetNoticeBoardTitle()
        {
            Assert.Equal(101, _sutNoticeBoard.NoticeBoardID);
        }
        [Fact]
        public void GetNoticeBoardNumThreads()
        {
            Assert.Equal(4,_sutNoticeBoard.getNumberOfThreads());
        }

        [Fact]
        public void GetNoticeBoardThreadsList()
        {
            Assert.NotNull(_sutNoticeBoard.noticeBoardThreadIDs);
            Assert.Equal(1,_sutNoticeBoard.noticeBoardThreadIDs[0]);
            Assert.Equal(2,_sutNoticeBoard.noticeBoardThreadIDs[1]);
            Assert.Equal(3,_sutNoticeBoard.noticeBoardThreadIDs[2]);
            Assert.Equal(4,_sutNoticeBoard.noticeBoardThreadIDs[3]);
            
        }






    }
}