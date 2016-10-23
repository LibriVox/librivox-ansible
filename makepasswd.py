#!/usr/bin/env python

# This is a helper script to generate user passwords and their SHA-512 hashes.
# The intended use case is to save the hash as a variable in secrets.yml,
# putting the plaintext password in a comment. The password can be sent to the
# user, and the hash can be deployed with Ansible.

import crypt
import random
import string

password = ''.join(random.SystemRandom().choice(
    string.ascii_uppercase +
    string.ascii_lowercase +
    string.digits) for _ in range(16))

salt = ''.join(random.SystemRandom().choice(
    string.ascii_uppercase +
    string.ascii_lowercase +
    string.digits) for _ in range(10))

print('Password: %s' % password)
print('SHA-512 hash: %s' % crypt.crypt(password, '$6$%s' % salt))
