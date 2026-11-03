import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Presentation-only piece representation for tray preview in Phase 04.
///
/// NOTE: This is strictly a UI preview model. The formal game-engine shape
/// definitions and piece models will be created in Phase 05.
class PreviewPiece {
  const PreviewPiece({
    required this.id,
    required this.matrix,
    required this.color,
  });

  final String id;
  final List<List<bool>> matrix;
  final Color color;

  int get rows => matrix.length;
  int get cols => matrix.isEmpty ? 0 : matrix.first.length;
}

/// Presentation-only model representing 10x10 board cells and preview HUD state.
class GameScreenPreviewData {
  const GameScreenPreviewData({
    required this.grid,
    required this.previewPieces,
    this.score = 0,
    this.bestScore,
  });

  /// 10x10 board matrix where null represents an empty cell, and a [Color]
  /// represents an occupied block.
  final List<List<Color?>> grid;

  /// Exactly three preview pieces displayed in the piece tray.
  final List<PreviewPiece> previewPieces;

  /// Current session score.
  final int score;

  /// High score / best score (null if no previous record exists).
  final int? bestScore;

  static const int boardRows = 10;
  static const int boardCols = 10;
  static const int totalCells = boardRows * boardCols;

  /// Factory creating an empty 10x10 new-game board with three standard preview pieces.
  factory GameScreenPreviewData.empty() {
    return GameScreenPreviewData(
      grid: List.generate(
        boardRows,
        (_) => List.generate(boardCols, (_) => null),
      ),
      previewPieces: _defaultPreviewPieces(),
      score: 0,
      bestScore: null,
    );
  }

  /// Factory creating an optional decorative sample arrangement to verify glossy
  /// occupied cell rendering on the 10x10 board.
  factory GameScreenPreviewData.samplePreview() {
    final grid = List.generate(
      boardRows,
      (_) => List.generate(boardCols, (_) => null as Color?),
    );

    // Decorative 2x2 block at bottom-left
    grid[8][0] = AppColors.blockBlue;
    grid[8][1] = AppColors.blockBlue;
    grid[9][0] = AppColors.blockBlue;
    grid[9][1] = AppColors.blockBlue;

    // Decorative 3-line at bottom
    grid[9][4] = AppColors.blockOrange;
    grid[9][5] = AppColors.blockOrange;
    grid[9][6] = AppColors.blockOrange;

    // Decorative L-shape
    grid[7][7] = AppColors.blockPurple;
    grid[8][7] = AppColors.blockPurple;
    grid[9][7] = AppColors.blockPurple;
    grid[9][8] = AppColors.blockPurple;

    return GameScreenPreviewData(
      grid: grid,
      previewPieces: _defaultPreviewPieces(),
      score: 0,
      bestScore: null,
    );
  }

  /// Standard illustrative preview pieces for the tray.
  static List<PreviewPiece> _defaultPreviewPieces() {
    return [
      // 1. Horizontal 4-cell line
      const PreviewPiece(
        id: 'line_4',
        matrix: [
          [true, true, true, true],
        ],
        color: AppColors.blockCyan,
      ),
      // 2. 2x2 square block
      const PreviewPiece(
        id: 'square_2x2',
        matrix: [
          [true, true],
          [true, true],
        ],
        color: AppColors.blockYellow,
      ),
      // 3. L-shaped block
      const PreviewPiece(
        id: 'l_shape',
        matrix: [
          [true, false],
          [true, false],
          [true, true],
        ],
        color: AppColors.blockPink,
      ),
    ];
  }
}

