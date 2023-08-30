#!/usr/bin/env python
# coding: utf-8

# In[2]:


from cryptography.hazmat.primitives import padding
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives import hmac
from base64 import urlsafe_b64encode, urlsafe_b64decode

# Input values (change these to match your actual values)
name = row5.Name
creditCard = row5.CreditCard

# Encryption key
encryption_key = b'r3aLly$Tr0ngK3y#f0rEncryp7!0n'  # Convert to bytes

# Initialize the encryption algorithm
salt = b'salt_for_encryption'  # Change this to a unique salt
iterations = 100000  # Number of iterations
kdf = PBKDF2HMAC(
    algorithm=hashes.SHA256(),
    iterations=iterations,
    salt=salt,
    length=32  # Length of the derived key
)
key = urlsafe_b64encode(kdf.derive(encryption_key))
cipher = Cipher(algorithms.AES(key), modes.ECB())

# Function to perform encryption
def encrypt(value, cipher):
    padder = padding.PKCS7(128).padder()
    padded_data = padder.update(value.encode()) + padder.finalize()
    encryptor = cipher.encryptor()
    encrypted_data = encryptor.update(padded_data) + encryptor.finalize()
    return urlsafe_b64encode(encrypted_data).decode()

# Perform encryption
encrypted_name = encrypt(name, cipher)
encrypted_creditCard = encrypt(creditCard, cipher)

# Output columns
row6.Name = encrypted_name
row6.CreditCard = encrypted_creditCard

