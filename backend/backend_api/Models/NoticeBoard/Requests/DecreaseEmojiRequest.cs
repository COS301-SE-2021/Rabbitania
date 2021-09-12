namespace backend_api.Models.NoticeBoard.Requests
{
    public class DecreaseEmojiRequest
    {
        
        private string _emojiUTF;
        private int _noticeboardID;
        
        public DecreaseEmojiRequest(string emojiUtf, int noticeboardId)
        {
            _emojiUTF = emojiUtf;
            _noticeboardID = noticeboardId; 
        }

        public string EmojiUtf
        {
            get => _emojiUTF;
            set => _emojiUTF = value;
        }

        public int NoticeboardId
        {
            get => _noticeboardID;
            set => _noticeboardID = value;
        }
    }
}