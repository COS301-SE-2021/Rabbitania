namespace backend_api.Models.User.Requests
{
    public class EditProfileRequest
    {
        private int _userId;
        private string _firstName;
        private string _lastName;
        private string _phoneNumber;
        private string _userDescription;
        private string _userImage;
        private bool _isAdmin;
        private int _empLevel;
        
        public EditProfileRequest(int userId, string firstName, string lastName, string phoneNumber, string userDescription, string userImage, bool isAdmin, int empLevel)
        {
            this._userId = userId;
            this._firstName = firstName;
            this._lastName = lastName;
            this._phoneNumber = phoneNumber;
            this._userDescription = userDescription;
            this._userImage = userImage;
            this._isAdmin = isAdmin;
            this._empLevel = empLevel;
        }

        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }

        public string FirstName
        {
            get => _firstName;
            set => _firstName = value;
        }

        public string LastName
        {
            get => _lastName;
            set => _lastName = value;
        }

        public string PhoneNumber
        {
            get => _phoneNumber;
            set => _phoneNumber = value;
        }

        public string UserDescription
        {
            get => _userDescription;
            set => _userDescription = value;
        }

        public string UserImage
        {
            get => _userImage;
            set => _userImage = value;
        }

        public bool IsAdmin
        {
            get => _isAdmin;
            set => _isAdmin = value;
        }

        public int EmpLevel
        {
            get => _empLevel;
            set => _empLevel = value;
        }
    }
}