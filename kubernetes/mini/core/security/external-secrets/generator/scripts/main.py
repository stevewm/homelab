from fastapi import FastAPI
from pydantic import BaseModel, Field
from typing import List
import secrets
import string


app = FastAPI()

class SecretRequestSpec(BaseModel):
    type: str = Field(default="plaintext", title="Type of Secret", description="The type of secret (only plaintext is supported for now)", example="plaintext")
    args: dict = Field(default={ "length": 32 }, title="Additional Arguments", description="Additional arguments for the secret type", example={ "length": 32 })

class SecretRequest(BaseModel):
    key: str = Field(default=None, title="Secret Key", description="The key of the secret. This will be returned as a key in the response body and should be unique", example="api_token")
    value: SecretRequestSpec | None = Field(default=None, title="Secret Specifications", description="Characteristics of the secret", example={"type": "plaintext", "args": {"length": 32}})


@app.post("/")
def generate_secret(request: List[SecretRequest]):
    generated_secrets = {}
    for secret in request:
        generated_secrets[secret.key] = plaintext_secret(secret.value.length)

    return generated_secrets

def plaintext_secret(length: int) -> str:
    return ''.join(secrets.choice(string.ascii_letters + string.digits) for i in range(length))
