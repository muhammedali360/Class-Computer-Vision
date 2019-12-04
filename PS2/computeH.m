function H = computeH(t1,t2)
%first row y, second row x
t1=importdata(t1);
t2=importdata(t2);

%c1=max(t1);
%c2=max(t2);
%c3=max([c1,c2]);
%c3=c3/2;
%=(t1/c3);
%t2=(t2/c3);


%t1=rescale(t1,0,2);
%t2=rescale(t2,0,2);

[~,n]=size(t1);
A=zeros(2*n,9);
for i = 1:n
    A(2*i-1,:)=[t1(2,i) t1(1,i) 1 0 0 0 -1*t2(2,i)*t1(2,i) -1*t2(2,i)*t1(1,i) -1*t2(2,i)];
    A(2*i,:)=[0 0 0 t1(2,i) t1(1,i) 1 -1*t2(1,i)*t1(2,i) -1*t2(1,i)*t1(1,i) -1*t2(1,i)];
end

B=A'*A;
[vect,~] = eigs(B,1,"smallestabs");
%d = eigs(A,k,sigma) returns k eigenvalues based on the value of sigma. For example, eigs(A,k,'smallestabs') returns the k smallest magnitude eigenvalues.
H=zeros(3,3);
H(1,1:3)=vect(1:3,1);
H(2,1:3)=vect(4:6,1);
H(3,1:3)=vect(7:9,1);

end

