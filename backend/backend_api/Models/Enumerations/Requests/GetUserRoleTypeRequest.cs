namespace backend_api.Models.Enumerations.Requests
{
    public class GetUserRoleTypeRequest
    {
        private UserRoles _userRole;

        public GetUserRoleTypeRequest(UserRoles userRole)
        {
            _userRole = userRole;
        }

        public UserRoles UserRole
        {
            get => _userRole;
            set => _userRole = value;
        }
    }
}