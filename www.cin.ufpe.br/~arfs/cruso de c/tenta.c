int main (){ // int main(int, char**)

int x, y, z;
x = y = 10;
z= ++x;	// incrementou o x, e atribui a z;
x= -x;
y++;
x = x + y - (z--); //atribui z a x e decementa

    printf("x, y e z eh = %d %d %d\n", x, y, z);
    printf("x, y e z eh = %d %d %d\n", x, y, z);
    getche(); 

return 0;

}
