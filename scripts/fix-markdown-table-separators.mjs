/**
 * Fixes MD060 "compact" table separator rows: |---| → | --- |
 * Usage: node scripts/fix-markdown-table-separators.mjs [paths...]
 */
import { readFileSync, writeFileSync, readdirSync, statSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const rootDir = join(dirname(fileURLToPath(import.meta.url)), "..");

function isSeparatorRow(line) {
  const trimmed = line.trim();
  if (!trimmed.startsWith("|") || !trimmed.endsWith("|")) {
    return false;
  }
  const inner = trimmed.slice(1, -1);
  return /^[\s|:-]+$/.test(inner) && inner.includes("-");
}

function columnCount(line) {
  return line.trim().split("|").filter((cell) => cell.trim().length > 0).length;
}

function compactSeparator(columns) {
  return `| ${Array.from({ length: columns }, () => "---").join(" | ")} |`;
}

function fixTableSeparators(content) {
  const lines = content.split(/\r?\n/);
  let changed = false;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    if (!isSeparatorRow(line)) {
      continue;
    }

    const header = i > 0 ? lines[i - 1] : null;
    const columns = header?.trim().startsWith("|")
      ? columnCount(header)
      : columnCount(line);

    if (columns < 1) {
      continue;
    }

    const fixed = compactSeparator(columns);
    if (fixed !== line.trim()) {
      lines[i] = fixed;
      changed = true;
    }
  }

  return { content: lines.join("\n"), changed };
}

function collectMarkdownFiles(targetPath) {
  const abs = resolve(targetPath);
  const stat = statSync(abs, { throwIfNoEntry: false });
  if (!stat) {
    return [];
  }
  if (stat.isFile() && abs.endsWith(".md")) {
    return [abs];
  }
  if (!stat.isDirectory()) {
    return [];
  }

  const files = [];
  for (const entry of readdirSync(abs, { withFileTypes: true })) {
    if (entry.name.startsWith(".")) {
      continue;
    }
    const child = join(abs, entry.name);
    if (entry.isDirectory()) {
      files.push(...collectMarkdownFiles(child));
    } else if (entry.isFile() && entry.name.endsWith(".md")) {
      files.push(child);
    }
  }
  return files;
}

const defaultTargets = [
  join(rootDir, "config"),
  join(rootDir, "docs"),
  join(rootDir, "memory-bank"),
  join(rootDir, "Design.md"),
  join(rootDir, "dart_defines.README.md"),
];

const targets = process.argv.length > 2 ? process.argv.slice(2) : defaultTargets;
const files = [...new Set(targets.flatMap((target) => collectMarkdownFiles(target)))];

let updated = 0;
for (const file of files) {
  const original = readFileSync(file, "utf8");
  const { content, changed } = fixTableSeparators(original);
  if (!changed) {
    continue;
  }
  const normalized = content.endsWith("\n") ? content : `${content}\n`;
  writeFileSync(file, normalized, "utf8");
  updated += 1;
  console.log(`fixed: ${file.replace(/\\/g, "/")}`);
}

console.log(`Done. Updated ${updated} file(s).`);
