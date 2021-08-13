using System;
using System.Threading.Tasks;
using backend_api.Data.Enumerations;
using backend_api.Exceptions.Enumerations;
using backend_api.Models.Enumerations.Requests;
using backend_api.Models.Enumerations.Responses;

namespace backend_api.Services.Enumerations
{
    public class EnumService : IEnumService
    {
        private readonly IEnumRepository _enumRepository;

        public EnumService(IEnumRepository enumRepository)
        {
            _enumRepository = enumRepository;
        }

        public async Task<GetOfficeNameResponse> GetOfficeName(GetOfficeNameRequest request)
        {
            if (request.OfficeLocation < 0)
            {
                throw new InvalidOfficeRequestException("Error with enumerations");
            }
            
            return await _enumRepository.GetOfficeName(request);
        }
    }
}