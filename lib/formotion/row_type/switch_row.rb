motion_require 'base'

module Formotion
  module RowType
    class SwitchRow < Base
      include BW::KVO

      def build_cell(cell)
        cell.selectionStyle = self.row.selection_style || UITableViewCellSelectionStyleNone
        switchView = UISwitch.alloc.initWithFrame(CGRectZero)
        switchView.accessibilityLabel = (row.title || "") + " Switch"
        cell.accessoryView = cell.editingAccessoryView = switchView
        switchView.setOn(row.value || false, animated:false)
        switchView.setOnTintColor(row.tint_color) if row.tint_color
        switchView.when(UIControlEventValueChanged) do
          break_with_semaphore do
            row.value = switchView.isOn
          end
        end
        switchView.userInteractionEnabled = row.editable?
        observe(self.row, "value") do |old_value, new_value|
          break_with_semaphore do
            switchView.setOn(row.value || false, animated: false)
          end
        end
        nil
      end

    end
  end
end
