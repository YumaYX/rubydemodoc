This code snippet demonstrates RSA encryption and decryption. Here's a breakdown:

*   **RSA Key Generation:**
    *   `OpenSSL::PKey::RSA.generate(2048)`:  Generates a new RSA key pair (private and public keys) with a key size of 2048 bits.  This creates a private key for decryption and a public key for encryption.

*   **Encryption:**
    *   `rsa_public.public_encrypt(secret)`:  Encrypts the string "Ruby" using the public key.  The result, `enc_data`, contains the ciphertext.

*   **Decryption:**
    *   `rsa_private.private_decrypt(enc_data)`: Decrypts the ciphertext `enc_data` back into the original string "Ruby" using the private key.  This process recovers the original secret string.
