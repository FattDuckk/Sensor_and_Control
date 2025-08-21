function Volume=polygon2voxel(FV,VolumeSize,mode,Yxz)

    if(nargin<4), Yxz=true; end
        
    % Check VolumeSize size
    if(length(VolumeSize)==1)
        VolumeSize=[VolumeSize VolumeSize VolumeSize];
    end
    if(length(VolumeSize)~=3)
        error('polygon2voxel:inputs','VolumeSize must be a array of 3 elements ')
    end
    Vertices = FV.vertices;
    Faces = FV.faces;
    % Volume Size must always be an integer value
    VolumeSize=round(VolumeSize);
    sizev=size(Vertices);
    % Check size of vertice array
    if((sizev(2)~=3)||(length(sizev)~=2))
        error('polygon2voxel:inputs','The vertice list is not a m x 3 array')
    end
    sizef=size(Faces);
    % Check size of vertice array
    if((sizef(2)~=3)||(length(sizef)~=2))
        error('polygon2voxel:inputs','The vertice list is not a m x 3 array')
    end
    % Check if vertice indices exist
    if(max(Faces(:))>size(Vertices,1))
        error('polygon2voxel:inputs','The face list contains an undefined vertex index')
    end
    % Check if vertice indices exist
    if(min(Faces(:))<1)
        error('polygon2voxel:inputs','The face list contains an vertex index smaller then 1')
    end
    % Matlab dimension convention YXZ
    if(Yxz)
        Vertices=Vertices(:,[2 1 3]); 
    end
    switch(lower(mode(1:2)))
        case {'au'} % auto
            % Make all vertices-coordinates positive
            Vertices=bsxfun(@minus,Vertices,min(Vertices));
            scaling=min((VolumeSize-1)./max(Vertices));
            % Make the vertices-coordinates to range from 0 to 100
            Vertices=Vertices*scaling+1;
            Wrap=0;
        case {'ce'} % center
            % Center the vertices
            Vertices=bsxfun(@plus,Vertices,VolumeSize/2);
            Wrap=0;
        case {'wr'} %wrap
            Wrap=1;
        case{'cl'} % clamp
            Wrap=2;
        otherwise
            Wrap=0;
    end
    Volume = false(VolumeSize);
    VerticesA = Vertices(Faces(:,1),:);
    VerticesB = Vertices(Faces(:,2),:);
    VerticesC = Vertices(Faces(:,3),:);
    while(~isempty(VerticesA))
        VolumeSize = size(Volume);
        
        if(Wrap == 0)
            % Only draw inside voxel
            checkA=~((VerticesA(:,1)<1)|(VerticesA(:,2)<1)|(VerticesA(:,3)<1)|(VerticesA(:,1)>VolumeSize(1))|(VerticesA(:,2)>VolumeSize(2))|(VerticesA(:,3)>VolumeSize(3)));
            checkB=~((VerticesB(:,1)<1)|(VerticesB(:,2)<1)|(VerticesB(:,3)<1)|(VerticesB(:,1)>VolumeSize(1))|(VerticesB(:,2)>VolumeSize(2))|(VerticesB(:,3)>VolumeSize(3)));
            checkC=~((VerticesC(:,1)<1)|(VerticesC(:,2)<1)|(VerticesC(:,3)<1)|(VerticesC(:,1)>VolumeSize(1))|(VerticesC(:,2)>VolumeSize(2))|(VerticesC(:,3)>VolumeSize(3)));
            VA =VerticesA(checkA,:);
            VB =VerticesB(checkB,:);
            VC =VerticesC(checkC,:);
        elseif(Wrap == 1)
            % wrap around
            VA = bsxfun(@mod,VerticesA-1,VolumeSize)+1;
            VB = bsxfun(@mod,VerticesB-1,VolumeSize)+1;
            VC = bsxfun(@mod,VerticesC-1,VolumeSize)+1;
        else
            % clamp to edge
            VA = bsxfun(@min,max(VerticesA,1),VolumeSize);
            VB = bsxfun(@min,max(VerticesB,1),VolumeSize);
            VC = bsxfun(@min,max(VerticesC,1),VolumeSize);
        end
        % Draw voxel
        Volume(sub2ind(VolumeSize,round(VA(:,1)),round(VA(:,2)), round(VA(:,3))))=true;
        Volume(sub2ind(VolumeSize,round(VB(:,1)),round(VB(:,2)), round(VB(:,3))))=true;
        Volume(sub2ind(VolumeSize,round(VC(:,1)),round(VC(:,2)), round(VC(:,3))))=true;
        
        
        VolumeSize = size(Volume);
        
        if(Wrap == 0)
            check1=(VerticesA(:,1)<1)&(VerticesB(:,1)<1)&(VerticesC(:,1)<1);
            check2=(VerticesA(:,2)<1)&(VerticesB(:,2)<1)&(VerticesC(:,2)<1);
            check3=(VerticesA(:,3)<1)&(VerticesB(:,3)<1)&(VerticesC(:,3)<1);
            check4=(VerticesA(:,1)>VolumeSize(1))&(VerticesB(:,1)>VolumeSize(1))&(VerticesC(:,1)>VolumeSize(1));
            check5=(VerticesA(:,2)>VolumeSize(2))&(VerticesB(:,2)>VolumeSize(2))&(VerticesC(:,2)>VolumeSize(2));
            check6=(VerticesA(:,3)>VolumeSize(3))&(VerticesB(:,3)>VolumeSize(3))&(VerticesC(:,3)>VolumeSize(3));
            outside = check1|check2|check3|check4|check5|check6;
            % Only keep inside faces
            VerticesA = VerticesA(~outside,:);
            VerticesB = VerticesB(~outside,:);
            VerticesC = VerticesC(~outside,:);
        end
        
        VerticesAnew = zeros(0,3);
        VerticesBnew = zeros(0,3);
        VerticesCnew = zeros(0,3);
        
        if(~isempty(VerticesA))
            % Split face, if edge larger than 0.5 voxel
            dist1=(VerticesA(:,1)-VerticesB(:,1)).*(VerticesA(:,1)-VerticesB(:,1))+(VerticesA(:,2)-VerticesB(:,2)).*(VerticesA(:,2)-VerticesB(:,2))+(VerticesA(:,3)-VerticesB(:,3)).*(VerticesA(:,3)-VerticesB(:,3));
            dist2=(VerticesC(:,1)-VerticesB(:,1)).*(VerticesC(:,1)-VerticesB(:,1))+(VerticesC(:,2)-VerticesB(:,2)).*(VerticesC(:,2)-VerticesB(:,2))+(VerticesC(:,3)-VerticesB(:,3)).*(VerticesC(:,3)-VerticesB(:,3));
            dist3=(VerticesA(:,1)-VerticesC(:,1)).*(VerticesA(:,1)-VerticesC(:,1))+(VerticesA(:,2)-VerticesC(:,2)).*(VerticesA(:,2)-VerticesC(:,2))+(VerticesA(:,3)-VerticesC(:,3)).*(VerticesA(:,3)-VerticesC(:,3));
            
            [maxdist,maxindex] = max([dist1,dist2,dist3],[],2);
            
            split = maxdist > 0.5;
            m1 = maxindex == 1 & split;
            m2 = maxindex == 2 & split;
            m3 = maxindex == 3 & split;
            if(any(m1))
                VA = VerticesA(m1,:);
                VB = VerticesB(m1,:);
                VC = VerticesC(m1,:);
                VN=(VA+VB)/2;
                
                VerticesAnew = [VerticesAnew;VN;VA];
                VerticesBnew = [VerticesBnew;VB;VN];
                VerticesCnew = [VerticesCnew;VC;VC];
            end
            
            if(any(m2))
                VA = VerticesA(m2,:);
                VB = VerticesB(m2,:);
                VC = VerticesC(m2,:);
                VN=(VC+VB)/2;
                
                VerticesAnew = [VerticesAnew;VA;VA];
                VerticesBnew = [VerticesBnew;VN;VB];
                VerticesCnew = [VerticesCnew;VC;VN];
            end
            
            if(any(m3))
                VA = VerticesA(m3,:);
                VB = VerticesB(m3,:);
                VC = VerticesC(m3,:);
                VN=(VC+VA)/2;
                
                VerticesAnew = [VerticesAnew;VN;VA];
                VerticesBnew = [VerticesBnew;VB;VB];
                VerticesCnew = [VerticesCnew;VC;VN];
            end
        end
        VerticesA = VerticesAnew;
        VerticesB = VerticesBnew;
        VerticesC = VerticesCnew;
    end
end