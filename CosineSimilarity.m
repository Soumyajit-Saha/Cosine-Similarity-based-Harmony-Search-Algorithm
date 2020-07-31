function [sim] = CosineSimilarity(p,q)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
p=p';
q=q';

if isvector(p)==0 || isvector(q)==0
    error('p and q have to be vectors!')
end
if length(p)~=length(q)
    error('p and q have to be same length!')
end
xy   = dot(p,q);
nx   = norm(p);
ny   = norm(q);
nxny = nx*ny;
sim   = xy/nxny;

end

