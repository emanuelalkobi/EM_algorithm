%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author    : Aman Gupta                                                  %
% Function  : DBSCAN                                                      %
% Inputs    : Data     - The data points in R^d.                          %
%           : distFunc - Definition of distance.                          %
%           : eps      - The radius (distance threshold).                 %
%           : minPts   - Min. Number of points in a cluster.              %
% Outputs   : pt       - Vector of length NumOfCenters with indices of    %
%                        points belonging to that cluster.                %
%             ptC      - Vector of cluster label associated to each point.%
%             centers  - Vector (d*NumOfCenters) with centers of clusters.%
% Variable Naming Convention: (var)_(property); pt--point, C--cluster     %
%                                                                         %
%                                                                         %  
function [label] = DBSCAN(Data,dist,eps,minPts)
    %% Pre-Allocating Output Parameters
    [~,n] = size(Data);     % d-NumOfDimensions(features),n-NumberOfPoints.
    label = zeros(n,1);     % Cluster label vector, jth entry is label of j
    noise = zeros(n,1);     % noise vector, j row = jth point labeled noise
    visited = zeros(n,1);   % definition vector (visited = label defined) 
    
    %% DBSCAN                           % Pseudo Code (Wikipedia)
    C = 0;                              % Initialize a cluster Counter
    for p = 1:n                         % For point p in Data
      if (~visited(p))                  % if not defined p's label earlier
        N = RangeQuery(Data,...         % idx of eps-Neighbourhood pts of P 
                       dist,...         % (including P)
                       p,...
                       eps);
        if (length(N) < minPts)         % If no. of neighbour of p < minPts
          noise(N) = 1;                 % label them as NOISE
          continue;                     % Check the next point
        else
          C = C+1;                      % else, p is a CORE point 
          label(p) = C;                 % form a cluster using p
          visited(p) = 1;               % define a label for p, mark visit

          S = setdiff(N,p);             % remove the p from the neihbours
          q = 1;                        % start an indexing over neighbours
          while true
            if (noise(S(q)) == 1)       % if the neighbour q was noise
              label(S(q)) = C;          % label q as the cluster boundary
              visited(S(q)) = 1;        % mark the visit to q
            end
            if (~visited(S(q)))         % if q is not yet visited
              label(S(q)) = C;          % still add it to the cluster
              visited(S(q)) = 1;        % and mark its visit
              qN = RangeQuery(Data,...  % idx of eps-Neighbourhood pts of q
                              dist,...  % including q
                              S(q),...
                              eps);
              if (length(qN) >= minPts) % if no. of nbr near q > minPts.
                S = union(S,qN);        % CHECK
                label(qN) = C;          % CHECK, label them C
                visited(qN) = 1;        % CHECK
              end
            else
              q = q + 1;
            end
            if(q > numel(S))
                break;
            end
          end
        end
      else
        continue;
      end
    end

%% Range Query    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author    : Aman Gupta                                                  %
% Function  : RangeQuery                                                  %
% Inputs    : Data     - The data points in R^d.                          %
%           : distFunc - Definition of distance.                          %
%           : pt       - The index of the points to find its neighbours   %
%           : eps      - The radius (distance threshold).                 %
% Outputs   : neighbours - an index vector of neighbours points of 'pt'   %
%                          which are eps close (defined by distFunc)      %
%                          to pt. Includes the index of 'pt' as well      %
%                                                                         %
%                                                                         %  
function [neighbours] = RangeQuery(Data,distFunc,pt,eps)
    neighbours = find(distFunc(Data,Data(:,pt))<=eps);
end

end