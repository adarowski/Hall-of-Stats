module PositionHelper
  def top_five_list(list, title, class_name)
    render partial: 'position/position_top_five_list',
      locals: { list: list, title: title, class_name: class_name }
  end
end
