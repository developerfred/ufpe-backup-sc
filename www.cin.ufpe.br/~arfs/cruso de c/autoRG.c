

int somarQuadrado(int a, int b) {
    auto int quadrado(int); // prot�tipo da fun��o

    // agora a fun��o auto pode ser chamada antes de ser implementada
    int retorno = quadrado(a) + quadrado(b);

    int quadrado(int z) {
        return z * z;
    }

    return retorno;
}

int main() {
    printf("2^2 + 10^2 = %d\n", somarQuadrado(2,10));
    getche(); 
    return 0;
}
