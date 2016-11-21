class BrowserController < ApplicationController
  after_filter :cors_set_access_control_headers
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET'
  end
  def index
    @current = 'demo'
    @graph = CtGraph.new
		@fens, @sans = fens_sans_from_graph(@graph)
  end
  def make_move
    error_string = san = fen = nil
    @graph = CtGraph.new.from_pgn(params[:graph])
    if move_string = params[:move]
      if move = @graph.move_from_san(move_string)
        san = @graph.move_to_san(move)
        @graph.make_move(move)
        fen = @graph.to_fen
      else
        error_string = "illegal move: #{move_string}"
      end
    else
      error_string = 'make_move error: missing move'
    end
    if error_string
      render js: %(
        controller.setFlash('#{error_string}');
        controller.board.drawPosition();
      )
    else
      render js: %(
        controller.clearFlash();
        controller.game.addMove('#{fen}', '#{san}');
      )
    end
  end
  def load_pgn
    pgn = params[:pgn]
    graph = CtGraph.new
    error_string = nil
    begin
      graph.from_pgn(pgn)
			fens, sans = fens_sans_from_graph(graph)
    rescue Exception => e
      error_string = e.message
    end
    if error_string
      render js: %(
        controller.setFlash('#{error_string}');
      )
    else
      render js: %(
        controller.clearFlash();
        controller.game.load(#{fens.to_json}, #{sans.to_json});
      )
    end
  end
  def statistics
    @fen = params[:fen]
    @graph = CtGraph.new
    @graph.from_fen(@fen)
    ct_position = @graph.position
    @position = Position.find_ct_position(ct_position)
    # if @position
    #   @is_white_to_move = ct_position.is_white_to_move
    #   @prev_strength = @position.strength(@is_white_to_move)
    #   @prev_sharpness = @position.sharpness(@is_white_to_move)
    # end
    render :partial => "statistics", :layout => false
  end

private

  def fens_sans_from_graph(graph)
    fens = []
    sans = []
    graph.for_each_move_made do |move|
      fens << graph.to_fen
      sans << graph.move_to_san(move)
    end
    fens << graph.to_fen
		return [fens, sans]
	end

end
