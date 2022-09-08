# HDBSCAN Clustering
#
#   References:
#
#       Martin Ester, Hans-peter Kriegel, Jörg S, and Xiaowei Xu
#       A density-based algorithm for discovering clusters
#       in large spatial databases with noise. 1996.
#

"""
    HdbscanResult <: ClusteringResult

The output of [`dbscan`](@ref) function (distance matrix-based implementation).

# Fields
 - `seeds::Vector{Int}`: indices of cluster starting points
 - `assignments::Vector{Int}`: vector of clusters indices, where each point was assigned to
 - `counts::Vector{Int}`: cluster sizes (number of assigned points)
"""
mutable struct HdbscanResult <: ClusteringResult
    assignments::Vector{Int}    # assignments, size (n,)
    counts::Vector{Int}         # number of points in each cluster, size (k,)
end

## main algorithm

"""
    hdbscan(points::AbstractMatrix, mpts::Real, metric::MinkowskiMetric = Euclidean
           [leafsize], [min_neighbors], [min_cluster_size]) -> Vector{HdbscanCluster}

Cluster `points` using the HDBSCAN (hierarchical density-based spatial clustering of
applications with noise) algorithm.

# Arguments
 - `points`: the ``d×n`` matrix of points. `points[:, j]` is a
   ``d``-dimensional coordinates of ``j``-th point
 - `mpts::Real`: the core distance is the distance to the mpts-th nearest neighbor

Optional keyword arguments to control the algorithm:
 - `leafsize::Int` (defaults to 20): the number of points binned in each
   leaf node in the `KDTree` or `BallTree`
 - `min_cluster_size::Int` (defaults to 1): the minimum number of points in
   a valid cluster

# Example
``` julia
points = randn(3, 10000)
# HDBSCAN clustering, clusters with less than 20 points will be discarded:
clusters = hdbscan(points, 15, min_cluster_size = 20)
```
"""
function hdbscan(points::AbstractMatrix, mpts::Real, metric::MinkowskiMetric = Euclidean; leafsize::Int = 20, kwargs ...)
    kdtree = KDTree(points; leafsize=leafsize)
    return _hdbscan(kdtree, points, mpts; kwargs ...)
end

#Use a ball tree for non-Minkowsky-type metrics
function hdbscan(points::AbstractMatrix, mpts::Real, metric::Metric; leafsize::Int = 20, kwargs ...)
    balltree = BallTree(points; leafsize=leafsize)
    return _hdbscan(balltree, points, mpts; kwargs ...)
end

function _hdbscan(tree::Union{KDTree, BallTree}, points::AbstractMatrix, mpts::Real;
                min_cluster_size::Int = 1)
				
    #TODO: Find core distance
	#TODO: Transform to mutual reachability distance
	#TODO: Get minimal spanning tree
	#TODO: Sort MST
	#TODO: Label clusters
	#TODO: Calculate stability
	#TODO: Optimized total stability
	
end


