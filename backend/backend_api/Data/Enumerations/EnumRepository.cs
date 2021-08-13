using System.Linq;
using System.Threading.Tasks;
using backend_api.Models.Enumerations;
using backend_api.Models.Enumerations.Requests;
using backend_api.Models.Enumerations.Responses;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Enumerations
{
    public class EnumRepository : IEnumRepository
    {
        private readonly EnumContext _enums;

        public EnumRepository(EnumContext enums)
        {
            _enums = enums;
        }

        public async Task<GetOfficeNameResponse> GetOfficeName(GetOfficeNameRequest request)
        {
            var officeName = await _enums.OfficeLocations
                .Where(x => x.OfficeLocation == request.OfficeLocation).FirstOrDefaultAsync();
            
            var response = new GetOfficeNameResponse(officeName.Name);

            return response;
        }
        
        public async Task<UserRolesModel> GetUserRoleType()
        {
            return null;
        }
    }
}