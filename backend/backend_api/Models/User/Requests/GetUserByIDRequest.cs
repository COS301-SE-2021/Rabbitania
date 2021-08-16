namespace backend_api.Models.User.Requests
{
    public class GetUserByIDRequest
    {
        private int UserID;

        public GetUserByIDRequest(int userId)
        {
            UserID = userId;
        }

        public int UserId
        {
            get => UserID;
            set => UserID = value;
        }
    }
}