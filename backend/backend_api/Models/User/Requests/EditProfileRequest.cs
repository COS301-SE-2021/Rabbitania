namespace backend_api.Models.User.Requests
{
    public class EditProfileRequest
    {
  
        private int _userId;
        private string _name;
        private string _phoneNumber;
        private string _userDescription;
        private string _userImage;
        private int _employeeLevel;
        private OfficeLocation _officeLocation;
        private UserRoles _userRoles;
        
        
        public EditProfileRequest()
        {
            
        }
        
        public EditProfileRequest(int userId, string name, string phoneNumber, string userDescription, string userImage, bool isAdmin, int empLevel, UserRoles userRoles, OfficeLocation officeLocation)
        {
            this._userId = userId;
            this._name = name;
            this._phoneNumber = phoneNumber;
            this._userDescription = userDescription;
            this._userImage = userImage;
            this._officeLocation = officeLocation;
            this._employeeLevel = empLevel;
            this._userRoles = userRoles;
        }
        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }

        public string Name
        {
            get => _name;
            set => _name = value;
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

        public OfficeLocation OfficeLocation
        {
            get => _officeLocation;
            set => _officeLocation = value;
        }
        public int EmployeeLevel
        {
            get => _employeeLevel;
            set => _employeeLevel = value;
        }
        
        public UserRoles UserRoles
        {
            get => _userRoles;
            set => _userRoles = value;
        }


    }
}