namespace backend_api.Services.Chat
{
    public interface IChatService
    {
        /// <summary>
        ///     Encrypts the Agora AppID using AES 128 bit
        ///     encryption. The key is stored as a secret, as
        ///     well as the AppID. This can later be changed
        ///     to encrypt any supplied text, specifically tokens
        ///     that have been generated (Agora or JWT).
        /// </summary>
        /// <returns> string containing the encrypted text </returns>
        string Encrypt();
    }
}