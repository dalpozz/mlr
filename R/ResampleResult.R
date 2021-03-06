#' @title ResampleResult object.
#' @name ResampleResult
#' @rdname ResampleResult
#' @description
#' A resample result is created by \code{\link{resample}} and
#' contains the following object members:
#' \describe{
#' \item{task.id [\code{character(1)}]:}{
#'   Name of the Task.
#' }
#' \item{learner.id [\code{character(1)}]:}{
#'   Name of the Learner.
#' }
#' \item{measures.test [\code{data.frame}]:}{
#'   Gives you access to performance measurements
#'   on the individual test sets. Rows correspond to sets in resampling iterations,
#'   columns to performance measures.
#' }
#' \item{measures.train [\code{data.frame}]:}{
#'   Gives you access to performance measurements
#'   on the individual training sets. Rows correspond to sets in resampling iterations,
#'   columns to performance measures. Usually not available, only if specifically requested,
#'   see general description above.
#' }
#' \item{aggr [\code{numeric}]:}{
#'   Named vector of aggregated performance values. Names are coded like
#'   this <measure>.<aggregation>.
#' }
#' \item{err.msgs [\code{data.frame}]:}{
#'   Number of rows equals resampling iterations
#'   and columns are: \dQuote{iter}, \dQuote{train}, \dQuote{predict}.
#'   Stores error messages generated during train or predict, if these were caught
#'   via \code{\link{configureMlr}}.
#' }
#' \item{pred [\code{\link{ResamplePrediction}}]:}{
#'   Container for all predictions during resampling.
#' }
#' \item{models [list of \code{\link{WrappedModel}}]:}{
#'   List of fitted models or \code{NULL}.
#' }
#' \item{extract [\code{list}]:}{
#'   List of extracted parts from fitted models or \code{NULL}.
#' }
#' }
#' The print method of this object gives a short overview, including
#' task and learner ids, aggregated measures as well as mean and standard
#' deviation of the measures.
#' @family resample
NULL

#' @export
print.ResampleResult = function(x, ...) {
  cat("Resample Result\n")
  catf("Task: %s", x$task.id)
  catf("Learner: %s", x$learner.id)
  m = x$measures.test[, -1L, drop = FALSE]
  Map(function(name, x, aggr) {
    catf("%s.aggr: %.2f", name, aggr)
    catf("%s.mean: %.2f", name, mean(x, na.rm = TRUE))
    catf("%s.sd: %.2f", name, sd(x, na.rm = TRUE))
  }, name = colnames(m), x = m, aggr = x$aggr)
  invisible(NULL)
}
