namespace backend_api.Models.User.Requests
{
    public class MakeUserAdminRequest
    {
        private int _userId;

        public MakeUserAdminRequest(int userId)
        {
            _userId = userId;
        }

        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }
    }
}