namespace backend_api.Models.User.Requests
{
    public class GetUserByIDRequest
    {
        private int _UserID;

        public GetUserByIDRequest(int userId)
        {
            _UserID = userId;
        }

        public int UserId
        {
            get => _UserID;
            set => _UserID = value;
        }
    }
}