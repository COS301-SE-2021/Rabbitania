using System.Collections.Generic;

namespace backend_api.Models.User.Requests
{
    public class CreateUserRequest
    {
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

        public int PhoneNumber
        {
            get => _phoneNumber;
            set => _phoneNumber = value;
        }

        public List<int> PinnedUserIds
        {
            get => _pinnedUserIds;
            set => _pinnedUserIds = value;
        }

        public string UserImage
        {
            get => _userImage;
            set => _userImage = value;
        }

        public string UserDescription
        {
            get => _userDescription;
            set => _userDescription = value;
        }

        public bool IsOnline
        {
            get => _isOnline;
            set => _isOnline = value;
        }

        public bool IsAdmin
        {
            get => _isAdmin;
            set => _isAdmin = value;
        }

        public int EmployeeLevel
        {
            get => _employeeLevel;
            set => _employeeLevel = value;
        }

        public UserRoles UserRole
        {
            get => _userRole;
            set => _userRole = value;
        }

        public OfficeLocation OfficeLocation
        {
            get => _officeLocation;
            set => _officeLocation = value;
        }

        private int _userId;
        private string _firstName;
        private string _lastName;
        private int _phoneNumber;
        private List<int> _pinnedUserIds;

        

        private string _userImage;
        private string _userDescription;
        private bool _isOnline;
        private bool _isAdmin;
        private int _employeeLevel;
        private UserRoles _userRole;
        private OfficeLocation _officeLocation;

        public CreateUserRequest(int userId, string firstName, string lastName, int phoneNumber, List<int> pinnedUserIds, string userImage, string userDescription, bool isOnline, bool isAdmin, int employeeLevel, UserRoles userRole, OfficeLocation officeLocation)
        {
            _userId = userId;
            _firstName = firstName;
            _lastName = lastName;
            _phoneNumber = phoneNumber;
            _pinnedUserIds = pinnedUserIds;
            _userImage = userImage;
            _userDescription = userDescription;
            _isOnline = isOnline;
            _isAdmin = isAdmin;
            _employeeLevel = employeeLevel;
            _userRole = userRole;
            _officeLocation = officeLocation;
        }


        public CreateUserRequest()
        {
            
        }

    }
}