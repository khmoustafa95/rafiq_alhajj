/// Progress state for a node on a sequential learning path.
enum LearningPathNodeStatus {
  completed,
  current,
  locked,
}

/// Resolves node status for sequential unlock paths (first incomplete = current).
LearningPathNodeStatus learningPathStatusFor({
  required int index,
  required int itemCount,
  required bool Function(int index) isCompleted,
}) {
  if (index < 0 || index >= itemCount) {
    return LearningPathNodeStatus.locked;
  }
  if (isCompleted(index)) {
    return LearningPathNodeStatus.completed;
  }

  for (var i = 0; i < itemCount; i++) {
    if (!isCompleted(i)) {
      return i == index
          ? LearningPathNodeStatus.current
          : LearningPathNodeStatus.locked;
    }
  }

  return LearningPathNodeStatus.completed;
}
