classdef Cubic < handle
    properties
        vertices
        faces
        scale
        patch
    end
    
    methods
        function this=Cubic(scale)
            this.scale=scale;
            this.vertices=scale*...
                [0 0 0;
                0 0 -1;
                0 1 -1;
                0 1 0;
                1 0 0;
                1 1 0;
                1 0 -1;
                1 1 -1];
            this.faces=...
                [1 4 3 2;
                7 8 3 2;
                3 4 6 8;
                5 6 8 7;
                1 4 6 5;
                1 2 7 5];
        end
        function render(this,ax,camMat)
            % homogeneous coordinates (x,y,1)
            vert=[this.vertices,ones(size(this.vertices,1),1)];
            % transform vertices from 3d world into 2d image plane
            vert2d=vert*camMat;
            % homogeneous coordinates (x,y,1) to (x,y)
            for i=1:size(vert2d,1)
                vertImage(i,1:2)=vert2d(i,1:2)/vert2d(i,3);
            end
            % draw pathch
            if isempty(this.patch) || ~isvalid(this.patch)
                hold(ax,'on');
                this.patch=patch('Faces',this.faces,'Vertices',vertImage,...
                    'facecolor','r','faceAlpha',0.5);
                hold(ax,'off');
            else
                this.patch.Vertices=vertImage;
            end
            drawnow;
        end
        function clear(this)
            delete(this.patch)
        end
    end
end

            