function [shortestDistances, paths] = dijkstra_algorithm()

% 设置节点和边的权重
nodes = {'A', 'B', 'C', 'D', 'E', 'F', 'G'};
edges = [
    0, 12, 0, 0, 0, 16, 14;
    12, 0, 10, 0, 0, 7, 0;
    0, 10, 0, 3, 5, 6, 0;
    0, 0, 3, 0, 4, 0, 0;
    0, 0, 5, 4, 0, 2, 0;
    16, 7, 6, 0, 2, 0, 9;
    14, 0, 0, 0, 0, 9, 0
];

% 初始化距离和路径
numNodes = length(nodes);
shortestDistances = Inf(1, numNodes);
shortestDistances(4) = 0;
paths = cell(1, numNodes);
paths{4} = 'D';

% 执行Dijkstra算法
visitedNodes = [];
currentNode = 4; % 从节点D开始
while length(visitedNodes) < numNodes
    visitedNodes = [visitedNodes, currentNode];
    
    for i = 1:numNodes
        if edges(currentNode, i) > 0
            newDistance = shortestDistances(currentNode) + edges(currentNode, i);
            if newDistance < shortestDistances(i)
                shortestDistances(i) = newDistance;
                paths{i} = [paths{currentNode}, nodes{i}];
            end
        end
    end
    
    minDistance = Inf;
    for j = 1:numNodes
        if ~ismember(j, visitedNodes) && shortestDistances(j) < minDistance
            minDistance = shortestDistances(j);
            currentNode = j;
        end
    end
end

% 输出最短距离和路径
disp('从节点D到各节点的最短距离为：');
disp(shortestDistances);
disp('从节点D到各节点的最短路径为：');
disp(paths);

end

