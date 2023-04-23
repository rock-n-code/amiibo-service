/// This error definitions represents any error happening while the client makes a request to the remote API and handles the respective response, excluding the decoding of the retrieved data into a particular model.
public enum AmiiboClientError: Error {
    /// The status code of the response is not the expected one, which is `.ok` (`200`).
    case responseCode(Int)
    /// The status code of the response was not received at all.
    case responseCodeNotFound
}
